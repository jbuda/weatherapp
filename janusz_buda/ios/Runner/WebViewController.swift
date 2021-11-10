//
//  WebViewController.swift
//  Runner
//
//  Created by Janusz Buda on 10/11/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    var url: String?
    var onCloseCallback: (() -> Void)?

    override func viewDidAppear(_ animated: Bool) {
        if let urlString = url, let urlRequest = URL(string: urlString) {
            webView.load(URLRequest(url: urlRequest))
        }
    }

    @IBAction func onClose(_ sender: UIButton) {
        onCloseCallback?()
    }
}
