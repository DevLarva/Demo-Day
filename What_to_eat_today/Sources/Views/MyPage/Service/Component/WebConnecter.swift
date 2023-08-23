//
//  WebConnecter.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/18.
//


import SwiftUI
import WebKit
import UIKit

struct WebConnecter: UIViewRepresentable {
    
    
    var urlToLoad: String
    
    
    func makeUIView(context: Context) -> WKWebView { //웹뷰 반환
        guard let url = URL(string: self.urlToLoad) else{
            return WKWebView()
        }
        
        
        let webview = WKWebView()
        
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
   
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebConnecter>) {
    }
    
}

struct WebConnecter_Previews: PreviewProvider {
    static var previews: some View {
        WebConnecter(urlToLoad: "https://github.com/DevLarva")
    }
}
