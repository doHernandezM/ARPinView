# ARPin

## If you need to show some pins, this is your gig.


Example:

```swift
let state = PinViewState(type: PinType.pwm.rawValue, background: Color.clear, horizontal: false)

var body: some View {
    ScrollView{
        PinView(state: self.state)
    }
}
```
