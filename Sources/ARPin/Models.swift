//
//  Models.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/24/21.
//

import SwiftUI

public enum Position: Int {
    case left, center, right, top, bottom
}

///Pin model for the Pin view
///
/// - Note: This is different from SwiftPi.Pin.
public class PinButton: Hashable, Codable {
    public static func == (lhs: PinButton, rhs: PinButton) -> Bool {
        return lhs.text == rhs.text
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    public var delegate:PinDelegate? = nil
    
    enum CodingKeys: String, CodingKey {
        case text
        case color
        case position
        case type
        case state
    }
    
    public var text = "A Pin"
    
    public var color: Color = Color.clear
    public var position: Int? = Position.left.rawValue
    public var type: Int = PinType.rPi.rawValue
    
    public var state: PinButtonState = PinButtonState(text: "8", enabled: true)
    
    public init() {}
    
    public init(text: String, color: Color, position: Int, type: Int) {
        self.text = text
        self.color = color
        self.position = position
        self.type = type
    }
    
    public func isVertical() -> Bool {
        if (self.position == Position.top.rawValue || self.position == Position.bottom.rawValue){
            return true
        }
        return false
    }
    
    public func label() -> String {
        var label = ""
        
        if isVertical() {
            for (i,char) in self.text.enumerated() {
                label = label + [char]
                if i != (self.text.count - 1) {
                    label = label + "\r"
                }
            }
            
            return label
        }
        
        return self.text
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
    
    public static func setPinType(type:PinType, pins:[PinButton]) -> [PinButton]{
        for (_,pin) in pins.enumerated() {
            pin.type = type.rawValue
        }
        return pins
    }
    
}

public var rPi40Pins: [PinButton] = [
    PinButton(text: "3v3.01", color: .orange, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "5v.01", color: .red, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.02", color: .pink, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "5v.02", color: .red, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.03", color: .pink, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.01", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.04", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.14", color: .purple, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.02", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.15", color: .purple, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.17", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.18", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.27", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.03", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.22", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.23", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "3v3.02", color: .orange, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.24", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.10", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.04", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.09", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.25", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.11", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.08", color: .blue, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.05", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.07", color: .blue, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "I2C.27", color: .yellow, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "I2C.28", color: .yellow, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.05", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.06", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.06", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.12", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.13", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.07", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.19", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.16", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.26", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.20", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "Ground.08", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    PinButton(text: "GPIO.21", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
]

public var analogPins: [PinButton] = [
    PinButton(text: "vDD", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A0", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "vREF", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A1", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "aGND", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A2", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "SCLK", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A3", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "MISO", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A4", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "MOSI", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A5", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "CE", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A6", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "dGND", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    PinButton(text: "A7", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
]

public var pwmPins: [PinButton] = [
    PinButton(text: "PWM.00", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.01", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.02", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.03", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.04", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.05", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.06", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.07", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.08", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.09", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.10", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.11", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.12", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.13", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.14", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    PinButton(text: "PWM.15", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
]

