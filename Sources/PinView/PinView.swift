//
//  PinView.swift
//  ARPinView
//
//  Created by Dennis Hernandez on 9/24/21.
//

import SwiftUI
import ManualStack


public struct PinViewState: Codable {
    var background:Color?
    var horizontal:Bool = true
}

struct PinView: View {
    var state: PinViewState
    var pins: [Pin] = []
    
    var body: some View {
        ManualStack(stackType: .Vertical){
            ForEach(pins, id:\.self){ pin in
                let pinLocation = pins.firstIndex(of: pin) ?? 0
                
                if pinLocation % 2 == 0 {
                    ManualStack(stackType: .Horizontal){PinControl(pin: pin)
                    PinControl(pin: pins[pinLocation + 1])
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}


struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView(state: PinViewState(background: .clear, horizontal: false), pins: rPiPins())
    }
}
