//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/23/21.
//

import SwiftUI
import SwiftyPi

public class PinButtonState: ObservableObject{
    public var iconLabel = ""
    public var label = ""
    
    @Published public var enabled:Bool = true
    @Published public var active:Bool = false
    
    @Published public var color: Color = Color.clear
    public var position: Position? = Position.left
    @Published public var deviceProtocol: DeviceProtocol = DeviceProtocol.GPIO
    
    func text() -> String {
        return label
    }
}

func pinCircle(color:Color, pin:PinButton) -> some View {
    ZStack{
        Circle()
            .foregroundColor(color)
            .frame(width:pin.squareHeight() - 1, height: pin.squareHeight() - 1)
//            .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
        Circle()
            .strokeBorder((Color.primary), lineWidth: 1.0)
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
                RoundedRectangle(cornerRadius: 18.0, style:.circular)
                    .frame(width:pin.squareHeight(), height: pin.squareHeight())
                    .foregroundColor(pin.state.color)
                    .clipped()
            } else {
                pinCircle(color: .gray, pin: pin)
            }
            Text(pin.state.iconLabel)
                .fontWeight(.medium)
                .frame(width: pin.squareHeight(), height: pin.squareHeight())
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 0.5, x: 0.0, y: 0.0)
            
        }
    }
}

struct PinLabel: View {
    var pin: PinButton
    
    var body: some View {
        ZStack {
            if pin.state.deviceProtocol != DeviceProtocol.PCA9685 {
                RoundedRectangle(cornerRadius: 18.0, style:.circular)
                    .addBorder(Color.primary, width: 1.0, cornerRadius: 18.0)
                    .frame(width: pin.frame().width, height: pin.frame().height)
                    .foregroundColor(pin.state.color)
//                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)
            } else {
                RoundedRectangle(cornerRadius: 18.0, style:.circular)
                    .foregroundColor(Color.gray)
                    .addBorder(Color.primary, width: 1.0, cornerRadius: 18.0)
                    .frame(width: pin.frame().width, height: pin.frame().height)
//                    .shadow(color: Color.black, radius: 1.0, x: 1.0, y: 1.0)
                    .saturation(0.75)

            }
            Text(pin.label())
                .frame(width: pin.frame().width, height: pin.frame().height)
                .allowsTightening(true)
                .flipsForRightToLeftLayoutDirection(true)
                .clipped()
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(Color.primary)
                .shadow(color: Color.primary, radius: 0.5, x: 0.0, y: 0.0)
        }
    }
}

public struct PinButtonView: View {
    
    public var pinButton: PinButton
    
    public var body: some View {
        return Group{
            if pinButton.isVertical(){
                VStack{
                    pinButtonBlock()
                }
                
            } else {
                HStack{
                    if (pinButton.state.deviceProtocol == DeviceProtocol.PCA9685) {
                        pinCircle(color: .black, pin: pinButton)
                            .padding(0.0)
                        pinCircle(color: .red, pin: pinButton)
                            .padding(0.0)
                        pinCircle(color: .yellow, pin: pinButton)
                            .padding(0.0)
                        
                    }
                    pinButtonBlock()
                }
            }
        }
        .onTapGesture {
            self.pinButton.delegate?.pinAction(pin: self.pinButton)
        }
        .onDrag{
//            if let data = self.pinButton.text().data(using: .utf8){
            return NSItemProvider(object: self.pinButton.text() as NSString)
//            }
//            return NSItemProvider()
        }
//        .gesture(
//            DragGesture()
//                .onChanged{ poop in
//                    print(poop.translation)
//                    self.pinButton.delegate?.pinAction(pin: self.pinButton)
//                }
//                .onEnded{ poop in
//                    print(poop.translation)
//                    self.pinButton.delegate?.pinAction(pin: self.pinButton)
//                }
//        )
//        .onDrag {
//            //                    self.pinButton.delegate?.pinAction(pin: self.pinButton)
//            NSItemProvider(object: self.pinButton)
//        }
        //        .onMoveCommand { moveCommandDirection in
        //            self.pinButton.delegate?.pinAction(pin: self.pinButton)
        //        }
    }
    
    public init() {
        self.pinButton = PinButton()
    }
    
    
    public init(pin:PinButton) {
        self.pinButton = pin
    }
    
    
    
    func pinButtonBlock() -> some View {
        Group{
            if (pinButton.state.position == Position.right || pinButton.state.position == Position.top) && pinButton.state.deviceProtocol != DeviceProtocol.PCA9685 {PinIcon(pin: pinButton).padding(0.0)}
            PinLabel(pin: pinButton)
                .padding(0.0)
            if (pinButton.state.position == Position.left || pinButton.state.position == Position.bottom) {PinIcon(pin: pinButton).padding(0.0)}
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
                    PinButtonView(pin: analogButtons[0])
                    PinButtonView(pin: analogButtons[2])
                }
                HStack{
                    PinButtonView(pin: analogButtons[1])
                    PinButtonView(pin: analogButtons[3])
                }
            }
            
            VStack{
                PinButtonView(pin: pca9685Buttons[0])
                PinButtonView(pin: pca9685Buttons[1])
                PinButtonView(pin: pca9685Buttons[2])
                PinButtonView(pin: pca9685Buttons[3])
            }
        }.preferredColorScheme(.light)
    }
    
}
