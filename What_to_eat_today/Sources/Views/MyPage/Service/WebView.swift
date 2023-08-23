//
//  WebView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/18.
//

import SwiftUI


import WebKit

struct WebView: View {
    var body: some View {
        
        ZStack {
            Webview(url: URL(string: "https://www.notion.so/d642266c66d84bf481823d702847250a?pvs=4")!)
        }
    }
}

struct Webview: UIViewRepresentable {
    let url: URL
    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
        return webview
    }
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
