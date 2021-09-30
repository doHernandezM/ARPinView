//
//  Models.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/24/21.
//
#if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)

import SwiftUI
import SwiftyPi

//MARK: Pin
///Pin model for the Pin view
///
/// - Note: This is different from SwiftPi.Pin.
public class PinButton: Hashable, Codable {
    public static func == (lhs: PinButton, rhs: PinButton) -> Bool {
        return lhs.state.text == rhs.state.text
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(state.text)
    }
    public var delegate:PinDelegate? = nil
    
    enum CodingKeys: String, CodingKey {
        case state
    }
    
    
    public var state: PinButtonState = PinButtonState(text: "8", enabled: true)
    
    public init() {}
    
    public init(text: String, position: Position, deviceProtocol: DeviceProtocol) {
        self.state.text = text
        self.state.color = pinColor(deviceProtocol: deviceProtocol)
        self.state.position = position
        self.state.deviceProtocol = deviceProtocol
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
            for (i,char) in self.state.text.enumerated() {
                label = label + [char]
                if i != (self.state.text.count - 1) {
                    label = label + "\r"
                }
            }
            
            return label
        }
        
        return self.state.text
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
    
}

public var rPi40Buttons:[PinButton] {
    get{
        var allButtons:[PinButton] = []
        
        for (i,pin) in SwiftyPi.rPi40Pins.enumerated() {
            var position = Position.right
            if (i % 2 == 0) {position = .left}
            allButtons.append(PinButton(text: pin.name, position: position, deviceProtocol: pin.deviceProtocol))
        }
        return allButtons
    }
}

public var analogButtons:[PinButton] {
    get{
        var allButtons:[PinButton] = []
        
        for (i,pin) in SwiftyPi.analogPins.enumerated() {
            var position = Position.bottom
            if (i % 2 == 0) {position = .top}
            allButtons.append(PinButton(text: pin.name, position: position, deviceProtocol: pin.deviceProtocol))
        }
        return allButtons
    }
}


public var pwmPins: [PinButton] {
    get{
        var allButtons:[PinButton] = []

        for (_,pin) in SwiftyPi.pwmPins.enumerated() {
            print(pin.name)
            allButtons.append(PinButton(text: pin.name, position: Position.right, deviceProtocol: DeviceProtocol.PCA9685))
        }
        return allButtons
//        PinButton(text: "PWM.00", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
        
//        return [
//        PinButton(text: "PWM.00", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.01", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.02", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.03", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.04", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.05", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.06", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.07", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.08", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.09", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.10", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.11", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.12", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.13", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.14", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685),
//        PinButton(text: "PWM.15", position: Position.right, deviceProtocol: DeviceProtocol.PCA9685)
//]
        
    }}

#endif
