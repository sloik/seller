// system
import Foundation
import SwiftUI
import WebKit

// local

// 3rd party
import AliasWonderland
import OptionalAPI

// Determine the target platform
#if os(macOS)
import AppKit
typealias ViewControllerRepresentable = NSViewControllerRepresentable
typealias ViewRepresentable = NSViewRepresentable
#else
import UIKit
typealias ViewControllerRepresentable = UIViewControllerRepresentable
typealias ViewRepresentable = UIViewRepresentable
#endif

struct WebView {

    let url: URL
    let redirectUrl: Consumer<URL?>

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // MARK: - WKNavigationDelegate

        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            parent.redirectUrl(webView.url)
        }
    }
}

extension WebView: ViewRepresentable {
    
    func makeNSView(context: Context) -> WKWebView {
        makeUIView(context: context)
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        updateUIView(nsView, context: context)
    }

    func makeUIView(context: Context) -> WKWebView {

        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }

}
