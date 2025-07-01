import SwiftUI

struct ConditionalButtonStyle : ButtonStyle
{
    var isEnabled : Bool

    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
            .opacity(configuration.isPressed && isEnabled ? 0.4 : 1)
            .animation(.default, value: configuration.isPressed)
            .disabled(!isEnabled)
    }
}
