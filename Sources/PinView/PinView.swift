//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/24/21.
//

import SwiftUI
import ManualStack

//public typealias Pins = [Pin]
//extension Pins {

public struct PinViewState: Codable {
    var type: Int = PinType.pwm.rawValue
    var background:Color?
    var horizontal:Bool = true
}

public enum PinType: Int, CaseIterable {
    case rPi, ic, pwm
}

public struct PinView: View {
    public var delegate: PinViewDelegate? = nil
    public var state: PinViewState
    public var backgroundColor: Color  {
        get {
            switch PinType(rawValue: self.state.type) {
            case .rPi:
                return .clear
            case .ic:
                return .black.opacity(0.75)
            case .pwm:
                return .clear
            default:
                return .clear
            }
        }
    }
    
    public var pins: [Pin] {
        get {
            var internalPins: [Pin] = []
            
            switch PinType(rawValue: self.state.type) {
            case .rPi:
                internalPins = Pin.setPinType(type: .rPi, pins: rPi40Pins)
            case .ic:
                internalPins = Pin.setPinType(type: .ic, pins: analogPins)
            case .pwm:
                internalPins = Pin.setPinType(type: .pwm, pins: pwmPins)
            default:
                break
            }
            return internalPins
        }
    }
    
    public var body: some View {
        let isHorizontal = (self.state.type == PinType.ic.rawValue)
        ManualStack(isVertical: !isHorizontal) {
            ForEach(pins, id:\.self){ pin in
                let pinLocation = pins.firstIndex(of: pin) ?? 0
                
                if (pinLocation % 2 == 0 && self.state.type != PinType.pwm.rawValue) {
                    ManualStack(isVertical: isHorizontal) {PinControl(pin: pin)
                        PinControl(pin: pins[pinLocation + 1])
                    }
                } else if (self.state.type == PinType.pwm.rawValue) {
                    PinControl(pin: pin)
                } else {
                    EmptyView()
                }
            }.padding(Edge.Set.all, 9.0)
        }.background(self.backgroundColor)
        
    }
    
    public init(state: PinViewState) {
        self.state = state
    }
    
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PinView(state: PinViewState(background: .clear, horizontal: false))
                .preferredColorScheme(.light)
            PinView(state: PinViewState(background: .clear, horizontal: false))
                .preferredColorScheme(.dark)
        }
    }
}

public protocol PinViewDelegate {
    func pinAction(pin:Pin)
}
public protocol PinDelegate {
    func pinAction(pin:Pin)
}
