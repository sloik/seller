// system
import SwiftUI

// Internal

// 3rd
import OptionalAPI


protocol SizingFrameType {
    
    static var instance: SizingFrameType { get }
    
    var size: CGSize { get }
}

#if os(macOS)
import AppKit
public typealias PlatformScreen = NSScreen

extension NSScreen: SizingFrameType {
    
    static var instance: SizingFrameType {
        NSScreen.main!
    }
    
    public var size: CGSize {
        frame.size
    }
}

#else
import UIKit
public typealias PlatformScreen = UIScreen

extension UIScreen: SizingFrameType {
    static var instance: SizingFrameType {
        UIScreen.main
    }
    
    public var size: CGSize {
        bounds.size
    }
}

#endif

struct MessagesView: View {
    @ObservedObject private var viewModel = MyMessagesViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView(viewModel: viewModel)
                .frame(height: 77)
            ScrollView {
                VStack(spacing: 17) {
                    MessagePreview()
                        .padding(.top, 30)
                    MessagePreview(hasAttachment: true)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MessagesView()
}

struct NavigationView: View {
    @ObservedObject var viewModel: MyMessagesViewModel
    private let filterPopupHeight = stride(from: 0.4, through: 1.0, by: 0.4).map { PresentationDetent.fraction($0) }
    private let iconWidth: CGFloat = 24.0
    private let dividerColor = Color(red: 0xB5 / 255.0, green: 0xB5 / 255.0, blue: 0xB5 / 255.0)
    
    init(viewModel: MyMessagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Wiadomości")
                    .font(.custom("SF Pro Display", size: 28))
                    .fontWeight(.medium)
                    .padding(.leading, 28)
                Spacer()
                Button(action: { viewModel.showingFilterSearchPopup.toggle() },
                       label: {
                    Image("threeDotsVerticalIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .padding(.horizontal, 8)
                })
                Button(action: { viewModel.showingFilterSearchPopup.toggle() },
                       label: {
                    Image("searchIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .padding(.trailing, 13)
                })
            }
            .frame(height: 77)
            Divider()
                .overlay(dividerColor)
        }
        .sheet(isPresented: $viewModel.showingFilterSearchPopup) {
           Text("Placeholder for popup view")
               .presentationDetents(Set(filterPopupHeight))
       }
    }
}

struct PlaceholderSearch: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(height: 32)
            .padding(.horizontal, 16)
            .foregroundColor(Color.gray.opacity(0.12))
            .padding(.bottom, 15)
    }
}

struct MessagePreview: View {
    init(hasAttachment: Bool = false, hasUnreadMessages: Bool = false) {
        self.hasAttachment = hasAttachment
        self.hasUnreadMessages = hasUnreadMessages
    }
    
    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
    private let circleWidth = 63.0
    private let circleLeftPadding = 30.0
    private let circleRightPadding = 16.0
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
                                        .frame(width: 19, height: 19)
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

struct GreenOnlineCircle: View {
    private let smallCircleWidth = 13.0
    private let smallCircleColor = Color(red: 0x47 / 255.0, green: 0xAA / 255.0, blue: 0x37 / 255.0)
    
    var body: some View {
        Circle()
            .frame(width: smallCircleWidth, height: smallCircleWidth).offset(x: 20, y: 24)
            .foregroundColor(smallCircleColor)
    }
}
