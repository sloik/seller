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
    var body: some View {
        VStack(spacing: 0) {
            NavigationView()
            PlaceholderSearch()
            ScrollView {
                MessagePreview()
                MessagePreview()
            }
            Spacer()
        }
    }
}

#Preview {
    MessagesView()
}

struct NavigationView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Spacer()
                Button(action: {},
                       label: {
                    Image(systemName: "ellipsis.circle").resizable().font(.title).foregroundColor(.blue).frame(width: 17, height: 17)
                        .padding(.all, 12)
                })
            }
            Text("Wiadomości")
                .font(.custom("Actor", fixedSize: 17))
                .fontWeight(.regular)
                .frame(height: 42)
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
    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
    private let circleWidth = 45.0
    private let circleLeftPadding = 26.0
    private let circleRightPadding = 12.0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Circle()
                        .foregroundColor(Color.blue)
                        .frame(width: circleWidth, height: circleWidth)
                        .padding(.leading, circleLeftPadding)
                        .padding(.trailing, circleRightPadding)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            Text("Tytuł oferty")
                                .font(.custom("Actor", fixedSize: 17))
                                .padding(.top, 8)
                            Spacer()
                            HStack(spacing: 14) {
                                Text("9:41 AM")
                                    .font(.custom("Actor", fixedSize: 15))
                                    .foregroundColor(fontColor)
                                Image(systemName: "chevron.right").resizable()
                                    .foregroundColor(fontColor)
                                    .frame(width: 6, height: 11)
                                    .padding(.trailing, 16)
                            }
                        }
                        Text("Nazwa kupującego")
                            .foregroundColor(fontColor)
                            .padding(.top, 8)
                        Spacer()
                        Divider()
                            .frame(height: 1)
                    }
                    .frame(width: PlatformScreen.instance.size.width - circleLeftPadding - circleWidth - circleRightPadding)
                }
            }
            .frame(width: PlatformScreen.instance.size.width, height: 76)
        }
    }
}

