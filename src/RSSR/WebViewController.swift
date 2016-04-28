//
//  WebViewController.swift
//  RSSR
//
//  Created by 李锦心 on 15/10/25.
//  Copyright © 2015年 李锦心. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    var url = NSURL()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        self.webView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view.snp_edges)
        }
        
        
    }

}
