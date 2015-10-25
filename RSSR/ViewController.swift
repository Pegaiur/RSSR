//
//  ViewController.swift
//  RSSR
//
//  Created by 李锦心 on 15/10/24.
//  Copyright © 2015年 李锦心. All rights reserved.
//

import UIKit
import MWFeedParser

class ViewController: UIViewController,MWFeedParserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://v2ex.com/feed/tab/tech.xml")
        let feedParser = MWFeedParser(feedURL: url)
        feedParser.delegate = self
        feedParser.feedParseType = ParseTypeFull
        feedParser.connectionType = ConnectionTypeSynchronously
        feedParser.parse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  MARK:MWFeedParserDelegate
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        print(info)
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        print(item)
    }
    
    
}

