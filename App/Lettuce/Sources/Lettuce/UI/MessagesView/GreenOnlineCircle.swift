// system
import SwiftUI

struct GreenOnlineCircle: View {
    private let smallCircleWidth = 13.0
    private let smallCircleColor = Color(red: 0x47 / 255.0, green: 0xAA / 255.0, blue: 0x37 / 255.0)
    
    var body: some View {
        Circle()
            .frame(width: smallCircleWidth, height: smallCircleWidth).offset(x: 20, y: 24)
            .foregroundColor(smallCircleColor)
    }
}
