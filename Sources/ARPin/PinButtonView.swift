//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/23/21.
//

#if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
import SwiftUI
import SwiftyPi

public struct PinButtonState: Codable {
    public var text = "8"
    public var label = ""
    public var enabled:Bool = true
    public var active:Bool = false
    
    public var color: Color = Color.clear
    public var position: Position? = Position.left
    public var deviceProtocol: DeviceProtocol = DeviceProtocol.GPIO
    }

func pinCircle(color:Color, pin:PinButton) -> some View {
    ZStack{
        Circle()
            .foregroundColor(color)
            .frame(width:pin.squareHeight() - 1, height: pin.squareHeight() - 1)
            .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
        Circle()
            .strokeBorder((Color.primary.opacity(0.75)), lineWidth: 1.0)
            .frame(width:pin.squareHeight(), height: pin.squareHeight())
            .foregroundColor(Color.clear)
            .clipped()
    
    }
}

struct PinIcon:View {
    var pin: PinButton
    
    var body: some View {
        ZStack {
            if pin.state.deviceProtocol == DeviceProtocol.PCA9685 {
                RoundedRectangle(cornerRadius: 9.0)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(pin.state.color)
                    .clipped()
            } else {
                pinCircle(color: .gray, pin: pin)
            }
            Text(pin.state.label)
                .fontWeight(.medium)
                .frame(width: pin.squareHeight(), height: pin.squareHeight())
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 1.0, x: 0.0, y: 0.0)
                
        }
    }
}

struct PinLabel: View {
    var pin: PinButton
    
    var body: some View {
        ZStack {
            if pin.state.deviceProtocol != DeviceProtocol.PCA9685 {
                RoundedRectangle(cornerRadius: 9.0)
                    .clipped()
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(pin.state.color)
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

public struct PinButtonView: View {
    public var pin: PinButton

    public var body: some View {
        return Group{
            if pin.isVertical(){
                VStack{
                    pinButtonBlock()
                }.clipped()
            } else {
                HStack{
                    if (pin.state.deviceProtocol == DeviceProtocol.PCA9685) {
                        pinCircle(color: .black, pin: pin)
                        pinCircle(color: .red, pin: pin)
                        pinCircle(color: .yellow, pin: pin)
                    }
                    pinButtonBlock()
                }
            }
        }.onTapGesture {
            self.pin.delegate?.pinAction(pin: self.pin)
        }
    }
    
    public init() {
        self.pin = PinButton()
    }

    
    public init(pin:PinButton) {
        self.pin = pin
    }
    

    
    func pinButtonBlock() -> some View {
        Group{
            if (pin.state.position == Position.right || pin.state.position == Position.top) && pin.state.deviceProtocol != DeviceProtocol.PCA9685 {PinIcon(pin: pin)}
            PinLabel(pin: pin)
            if (pin.state.position == Position.left || pin.state.position == Position.bottom) {PinIcon(pin: pin)}
        }
    }
}

struct PinButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack{
                VStack{
                    PinButtonView(pin: rPi40Buttons[0])
                    PinButtonView(pin: rPi40Buttons[2])
                }
                VStack{
                    PinButtonView(pin: rPi40Buttons[1])
                    PinButtonView(pin: rPi40Buttons[3])
                }
            }
            
            VStack{
                HStack{
                    PinButtonView(pin: analogPins[0])
                    PinButtonView(pin: analogPins[2])
                }
                HStack{
                    PinButtonView(pin: analogPins[1])
                    PinButtonView(pin: analogPins[3])
                }
            }
            
            VStack{
                PinButtonView(pin: pwmPins[0])
                PinButtonView(pin: pwmPins[1])
                PinButtonView(pin: pwmPins[2])
                PinButtonView(pin: pwmPins[3])
            }
        }.preferredColorScheme(.light)
    }
    
}

#endif
