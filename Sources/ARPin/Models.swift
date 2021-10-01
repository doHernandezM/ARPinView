//
//  Models.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/24/21.
//

import SwiftUI
import SwiftyPi

//MARK: Pin
///Pin model for the Pin view
///
/// - Note: This is different from SwiftPi.Pin.
public class PinButton: Hashable, Codable {
    public static func == (lhs: PinButton, rhs: PinButton) -> Bool {
        return lhs.state.iconLabel == rhs.state.iconLabel
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(state.iconLabel)
    }
    public var delegate:PinButtonDelegate? = nil
    
    enum CodingKeys: String, CodingKey {
        case state
    }
    
    public var state: PinButtonState = PinButtonState(iconLabel: "8", enabled: true)
    
    public init() {}
    
    public init(text: String, position: Position, deviceProtocol: DeviceProtocol) {
        self.state.label = text
        self.state.color = pinColor(deviceProtocol: deviceProtocol)
        self.state.position = position
        self.state.deviceProtocol = deviceProtocol
    }
    
    public init(pin: Pin, position: Position) {
        self.state.label = pin.state.name
        self.state.color = pinColor(deviceProtocol: pin.state.deviceProtocol)
        self.state.position = position
        self.state.deviceProtocol = pin.state.deviceProtocol
    }
    
    public func isVertical() -> Bool {
        if (self.state.position == Position.top || self.state.position == Position.bottom){
            return true
        }
        return false
    }
    
    public func label() -> String {
        var label = ""
        
        if isVertical() {
            for (i,char) in self.state.label.enumerated() {
                label = label + [char]
                if i != (self.state.label.count - 1) {
                    label = label + "\r"
                }
            }
            
            return label
        }
        
        return self.state.label
    }
    
    func frame() -> (width:Double,height:Double) {
        if self.isVertical() {
            return (26.0,126.0)
        }
        return (126.0,26.0)
    }
    
    func squareHeight() -> Double {
        return 26.0
    }
    
    public static func setPinProtocol(deviceProtocol:DeviceProtocol, pins:[PinButton]) -> [PinButton]{
        for (_,pin) in pins.enumerated() {
            pin.state.deviceProtocol = deviceProtocol
        }
        return pins
    }
    
    public func pinColor(deviceProtocol:DeviceProtocol) -> Color {
        switch deviceProtocol {
        case .GPIO:
            return Color.green
        case .PWM:
            return Color.yellow
        case .MCP3008:
            return Color.gray
        case .PCA9685:
            return Color.yellow
        case .UART:
            return Color.purple
        case .I2C:
            return Color.red
        case .SPI:
            return Color.blue
            
        case .ground:
            return Color.gray
        case .v5:
            return Color.pink
        case .v3:
            return Color.orange
        }
        
        //    return .accentColor
    }
    
}

public var rPi40Buttons:[PinButton] {
    get{
        var allButtons:[PinButton] = []
        
        for (i,pin) in pinsForProtocol(deviceProtocol: DeviceProtocol.GPIO).enumerated() {
            var position = Position.right
            if (i % 2 == 0) {position = .left}
            allButtons.append(PinButton(pin: pin, position: position))
        }
        return allButtons
    }
}

public var analogButtons:[PinButton] {
    get{
        var allButtons:[PinButton] = []
        
        for (i,pin) in pinsForProtocol(deviceProtocol: DeviceProtocol.MCP3008).enumerated() {
            var position = Position.bottom
            if (i % 2 == 0) {position = .top}
            allButtons.append(PinButton(pin: pin, position: position))
        }
        return allButtons
    }
}


public var pca9685Buttons: [PinButton] {
    get{
        var allButtons:[PinButton] = []
        
        for (_,pin) in pinsForProtocol(deviceProtocol: DeviceProtocol.PCA9685).enumerated() {
//            (pin.name)print
            allButtons.append(PinButton(pin: pin, position: Position.right))
        }
        return allButtons
        
    }}
