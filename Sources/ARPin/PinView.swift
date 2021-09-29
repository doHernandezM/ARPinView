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

///Use this to tell the ``PinView`` how to behave.
public struct PinViewState: Codable {
    public var type: Int = PinType.pwm.rawValue
    public var background:Color?
    public var horizontal:Bool = true
    
    public init(type: Int, background: Color, horizontal: Bool){
        self.type = type
        self.background = background
        self.horizontal = horizontal
    }
}

///Determine the type of ``Pin`` array to draw. rPI = 40 Pin Pi, ic = MCP3008, pwm = PCA9685
public enum PinType: Int, CaseIterable {
    case rPi, ic, pwm
}

///Provide the ``PinView``  with a ``PinViewState`` to get stated
public struct PinView: View {
    
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
    
    ///Makes the ``Pin`` consistent with the ``PinView``.
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
        ScrollView{
        ManualStack(isVertical: !isHorizontal) {
            ForEach(pins, id:\.self){ pin in
                let pinLocation = pins.firstIndex(of: pin) ?? 0
                
                if (pinLocation % 2 == 0 && self.state.type != PinType.pwm.rawValue) {
                    ManualStack(isVertical: isHorizontal) {PinButton(pin: pin)
                        if let individualPin = PinButton(pin: pins[pinLocation + 1]){individualPin}
                    }
                } else if (self.state.type == PinType.pwm.rawValue) {
                    PinButton(pin: pin)
                } else {
                    EmptyView()
                }
            }//.padding(Edge.Set.all, 9.0)
        }.background(self.backgroundColor)
        }
    }
    
    public init() {
        self.state = PinViewState(type: PinType.rPi.rawValue, background: .clear, horizontal: false)
    }

    public init(state: PinViewState, delegate:PinDelegate?) {
        self.state = state
        for pin in pins {
            pin.delegate = delegate
        }
    }
    
    public init(state: PinViewState) {
        self.state = state
    }
    
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PinView(state: PinViewState(type: PinType.rPi.rawValue, background: Color.clear, horizontal: false), delegate: nil)
                .preferredColorScheme(.light)
            PinView(state: PinViewState(type: PinType.rPi.rawValue, background: Color.clear, horizontal: false), delegate: nil)
                .preferredColorScheme(.dark)
        }
    }
}

public protocol PinDelegate {
    func pinAction(pin:Pin)
}
