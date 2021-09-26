//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/23/21.
//

import SwiftUI

struct PinStateView:View {
    var pin: Pin
    //    var is
    
    var body: some View {
        ZStack {
            if pin.type == PinType.pwm.rawValue {
                RoundedRectangle(cornerRadius: 9.0)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(pin.color)
            } else {
                Circle()
                    .foregroundColor(Color.gray)
                    .frame(width:pin.squareHeight() - 1, height: pin.squareHeight() - 1)
                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                Circle()
                    .strokeBorder((Color.primary), lineWidth: 3.0)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(Color.clear)
            }
            Text(pin.state.text)
                .font(.system(.title, design: .monospaced))
                .fontWeight(.medium)
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 1.0, x: 0.0, y: 0.0)
        }
    }
}

public struct PinState: Codable {
    var text = "8"
    var enabled:Bool = true
    var active:Bool = false
}

struct PinLabel: View {
    var pin: Pin
    
    var body: some View {
        ZStack {
            if pin.type != PinType.pwm.rawValue {
                RoundedRectangle(cornerRadius: 9.0)
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(pin.color)
                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)
            } else {
                RoundedRectangle(cornerRadius: 9.0)
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(Color.gray)
//                    .background(Color.secondary)
                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)
            }
            Text(pin.label())
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 1.0, x: 0.0, y: 0.0)
        }
    }
}

struct PinControl: View {
    var pin: Pin
    
    var body: some View {
        return Group{
            if pin.isVertical(){
                VStack{
                    pinControlBlock()
                }
            } else {
                HStack{
                    if (pin.type == PinType.pwm.rawValue) {
                        RoundedRectangle(cornerRadius: 9.0)
                            .frame(width:pin.squareHeight(), height: pin.squareHeight())
                            .foregroundColor(.black)
                        RoundedRectangle(cornerRadius: 9.0)
                            .frame(width:pin.squareHeight(), height: pin.squareHeight())
                            .foregroundColor(.red)
                    }
                    pinControlBlock()
                }
            }
        }.onTapGesture {
            print("\(pin.text) tapped")
        }
    }
    
    func pinControlBlock() -> some View {
        Group{
            if (pin.position == Position.right.rawValue || pin.position == Position.top.rawValue) {PinStateView(pin: pin)}
            PinLabel(pin: pin)
            if (pin.position == Position.left.rawValue || pin.position == Position.bottom.rawValue) {PinStateView(pin: pin)}
        }
    }
}

struct PinControl_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack{
                VStack{
                    PinControl(pin: rPi40Pins[0])
                    PinControl(pin: rPi40Pins[2])
                }
                VStack{
                    PinControl(pin: rPi40Pins[1])
                    PinControl(pin: rPi40Pins[3])
                }
            }
            
            VStack{
                HStack{
                    PinControl(pin: analogPins[0])
                    PinControl(pin: analogPins[2])
                }
                HStack{
                    PinControl(pin: analogPins[1])
                    PinControl(pin: analogPins[3])
                }
            }
            
            VStack{
                PinControl(pin: pwmPins[0])
                PinControl(pin: pwmPins[1])
                PinControl(pin: pwmPins[2])
                PinControl(pin: pwmPins[3])
            }
        }.preferredColorScheme(.light)
    }
    
}

