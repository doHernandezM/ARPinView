# ~~ARPin~~
#Deprecated
## ~~If you need to show some pins, this is your gig.
##See [SwiftyPi](https://github.com/doHernandezM/SwiftyPi)

Example:

```swift
let state = PinViewState(type: PinType.pwm.rawValue, background: Color.clear, horizontal: false)

var body: some View {
    ScrollView{
        PinView(state: self.state)
    }
}
```
