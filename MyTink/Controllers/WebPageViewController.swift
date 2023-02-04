//
//  WebPageViewController.swift
//  MyTink
//
//  Created by macbook on 04.02.2023.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    var urlString: String? = nil
    
    let pageWeb: WKWebView = {
        let pageWeb = WKWebView()
        pageWeb.translatesAutoresizingMaskIntoConstraints = false
        return pageWeb
    }()
    
    override func viewDidLoad() {
        setConstraints()
        loadPage()
    }
    
    func setConstraints() {
        view.addSubview(pageWeb)
        NSLayoutConstraint.activate([
            pageWeb.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageWeb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageWeb.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            pageWeb.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // фиолетовый ворнинг - это, если не ошибаюсь, проблема со стороны эпла
    func loadPage() {
        guard let urlString = urlString else {return}

        var UrlComponents = URLComponents(string: urlString)!
        UrlComponents.scheme = "https"
        let toURL = URL(string: UrlComponents.string!)
        let request = URLRequest(url: toURL!)
        pageWeb.load(request)

    }
    
}
