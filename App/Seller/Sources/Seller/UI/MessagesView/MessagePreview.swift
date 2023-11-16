// system
import SwiftUI

struct MessagePreview: View {
    init(hasAttachment: Bool = false, hasUnreadMessages: Bool = false) {
        self.hasAttachment = hasAttachment
        self.hasUnreadMessages = hasUnreadMessages
    }
    
    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
    private let circleWidth = 63.0
    private let circleLeftPadding = 30.0
    private let circleRightPadding = 16.0
    private let iconSize = 19.0
    private var hasAttachment: Bool = false
    private var hasUnreadMessages: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Circle()
                        .foregroundColor(Color.gray)
                        .frame(width: circleWidth, height: circleWidth)
                        .overlay(GreenOnlineCircle())
                        .padding(.leading, circleLeftPadding)
                        .padding(.trailing, circleRightPadding)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("User name")
                                    .font(.custom("SF Pro Display", fixedSize: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(alignment: .center, spacing: 0) {
                                    Image("attachmentIcon")
                                        .frame(width: iconSize, height: iconSize)
                                    Text("{offer:title}")
                                        .foregroundColor(fontColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.top, 6)
                            }
                            Spacer()
                            VStack(spacing: 0) {
                                Text("9:23")
                                    .font(.custom("SF Pro Display", fixedSize: 14))
                                    .foregroundColor(fontColor)
                                if hasAttachment {
                                    ZStack {
                                        Circle()
                                            .frame(height: 23)
                                        Text("2")
                                            .font(.custom("SF Pro Display", fixedSize: 14))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.top, 4)
                                }
                            }
                        }
                        .padding(.trailing, 43)
                    }
                }
            }
        }
    }
}
