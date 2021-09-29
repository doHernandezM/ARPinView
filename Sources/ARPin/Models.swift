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
public class Pin: Hashable, Codable {
    public static func == (lhs: Pin, rhs: Pin) -> Bool {
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
    
    public static func setPinType(type:PinType, pins:[Pin]) -> [Pin]{
        for (_,pin) in pins.enumerated() {
            pin.type = type.rawValue
        }
        return pins
    }
    
}

public var rPi40Pins: [Pin] = [
    Pin(text: "3v3.01", color: .orange, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "5v.01", color: .red, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.02", color: .pink, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "5v.02", color: .red, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.03", color: .pink, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.01", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.04", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.14", color: .purple, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.02", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.15", color: .purple, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.17", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.18", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.27", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.03", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.22", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.23", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "3v3.02", color: .orange, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.24", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.10", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.04", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.09", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.25", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.11", color: .blue, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.08", color: .blue, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.05", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.07", color: .blue, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "I2C.27", color: .yellow, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "I2C.28", color: .yellow, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.05", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.06", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.06", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.12", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.13", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.07", color: .gray, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.19", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.16", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.26", color: .green, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.20", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "Ground.08", color: .gray, position: Position.left.rawValue, type: PinType.rPi.rawValue),
    Pin(text: "GPIO.21", color: .green, position: Position.right.rawValue, type: PinType.rPi.rawValue),
]

public var analogPins: [Pin] = [
    Pin(text: "vDD", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A0", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "vREF", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A1", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "aGND", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A2", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "SCLK", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A3", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "MISO", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A4", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "MOSI", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A5", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "CE", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A6", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
    Pin(text: "dGND", color: .gray, position: Position.top.rawValue, type: PinType.ic.rawValue),
    Pin(text: "A7", color: .gray, position: Position.bottom.rawValue, type: PinType.ic.rawValue),
]

public var pwmPins: [Pin] = [
    Pin(text: "PWM.00", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.01", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.02", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.03", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.04", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.05", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.06", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.07", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.08", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.09", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.10", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.11", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.12", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.13", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.14", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
    Pin(text: "PWM.15", color: .yellow, position: Position.right.rawValue, type: PinType.pwm.rawValue),
]

