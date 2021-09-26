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
    var background:Color?
    var horizontal:Bool = true
}

public enum PinType: Int, CaseIterable {
    case rPi, ic, pwm
}

struct PinView: View {
    var delegate: PinViewDelegate? = nil
    var state: PinViewState
    var backgroundColor: Color  {
        get {
            switch self.type {
            case .rPi:
                return .clear
            case .ic:
                return .black.opacity(0.75)
            case .pwm:
                return .clear
                //            default:
                //              return .clear
            }
        }
    }
    
    var pins: [Pin] {
        get {
            var internalPins: [Pin] = []
            
            switch self.type {
            case .rPi:
                internalPins = Pin.setPinType(type: .rPi, pins: rPi40Pins)
            case .ic:
                internalPins = Pin.setPinType(type: .ic, pins: analogPins)
            case .pwm:
                internalPins = Pin.setPinType(type: .pwm, pins: pwmPins)
            }
            
            return internalPins
        }
    }
    var type: PinType = .pwm
    
    var body: some View {
        let isHorizontal = (type == .ic)
        ManualStack(isVertical: !isHorizontal) {
            ForEach(pins, id:\.self){ pin in
                let pinLocation = pins.firstIndex(of: pin) ?? 0
                
                if (pinLocation % 2 == 0 && type != .pwm) {
                    ManualStack(isVertical: isHorizontal) {PinControl(pin: pin)
                        PinControl(pin: pins[pinLocation + 1])
                    }
                } else if (type == .pwm) {
                    PinControl(pin: pin)
                } else {
                    EmptyView()
                }
            }.padding(Edge.Set.all, 9.0)
        }.background(self.backgroundColor)
        
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

protocol PinViewDelegate {
    func pinAction(pin:Pin)
}
protocol PinDelegate {
    func pinAction(pin:Pin)
}
