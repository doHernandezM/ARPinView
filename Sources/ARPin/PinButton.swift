//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/23/21.
//

import SwiftUI

public struct PinButtonState: Codable {
    var text = "8"
    var enabled:Bool = true
    var active:Bool = false
}

struct PinButtonIcon:View {
    var pin: Pin
    
    var body: some View {
        ZStack {
            if pin.type == PinType.pwm.rawValue {
                RoundedRectangle(cornerRadius: 9.0)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(pin.color)
                    .clipped()
            } else {
                Circle()
                    .foregroundColor(Color.gray)
                    .frame(width:pin.squareHeight() - 1, height: pin.squareHeight() - 1)
                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                Circle()
                    .strokeBorder((Color.primary), lineWidth: 3.0)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(Color.clear)
                    .clipped()
            }
            Text(pin.state.text)
                .fontWeight(.medium)
                .frame(width: pin.squareHeight(), height: pin.squareHeight())
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 1.0, x: 0.0, y: 0.0)
                
        }
    }
}

struct PinButtonLabel: View {
    var pin: Pin
    
    var body: some View {
        ZStack {
            if pin.type != PinType.pwm.rawValue {
                RoundedRectangle(cornerRadius: 9.0)
                    .clipped()
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(pin.color)
                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)
            } else {
                RoundedRectangle(cornerRadius: 9.0)
                    .clipped()
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(Color.gray)

                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)
                
            }
            Text(pin.label())
                .frame(width: pin.frame().width, height: pin.frame().height)
                .allowsTightening(true)
                .flipsForRightToLeftLayoutDirection(true)
                .clipped()
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 1.0, x: 0.0, y: 0.0)
        }
    }
}

public struct PinButton: View {
    public var pin: Pin

    public var body: some View {
        return Group{
            if pin.isVertical(){
                VStack{
                    pinButtonBlock()
                }.clipped()
            } else {
                HStack{
                    if (pin.type == PinType.pwm.rawValue) {
                        RoundedRectangle(cornerRadius: 9.0)
                            .clipped()
                            .frame(width:pin.squareHeight(), height: pin.squareHeight())
                            .foregroundColor(.black)
                        RoundedRectangle(cornerRadius: 9.0)
                            .clipped()
                            .frame(width:pin.squareHeight(), height: pin.squareHeight())
                            .foregroundColor(.red)
                    }
                    pinButtonBlock()
                }
            }
        }.onTapGesture {
            self.pin.delegate?.pinAction(pin: self.pin)
        }
    }
    
    public init() {
        self.pin = Pin()
    }

    
    public init(pin:Pin) {
        self.pin = pin
    }
    

    
    func pinButtonBlock() -> some View {
        Group{
            if (pin.position == Position.right.rawValue || pin.position == Position.top.rawValue) {PinButtonIcon(pin: pin)}
            PinButtonLabel(pin: pin)
            if (pin.position == Position.left.rawValue || pin.position == Position.bottom.rawValue) {PinButtonIcon(pin: pin)}
        }
    }
}

struct PinButton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack{
                VStack{
                    PinButton(pin: rPi40Pins[0])
                    PinButton(pin: rPi40Pins[2])
                }
                VStack{
                    PinButton(pin: rPi40Pins[1])
                    PinButton(pin: rPi40Pins[3])
                }
            }
            
            VStack{
                HStack{
                    PinButton(pin: analogPins[0])
                    PinButton(pin: analogPins[2])
                }
                HStack{
                    PinButton(pin: analogPins[1])
                    PinButton(pin: analogPins[3])
                }
            }
            
            VStack{
                PinButton(pin: pwmPins[0])
                PinButton(pin: pwmPins[1])
                PinButton(pin: pwmPins[2])
                PinButton(pin: pwmPins[3])
            }
        }.preferredColorScheme(.light)
    }
    
}
