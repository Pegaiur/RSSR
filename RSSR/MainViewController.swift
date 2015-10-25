//
//  MainViewController.swift
//  RSSR
//
//  Created by 李锦心 on 15/10/24.
//  Copyright © 2015年 李锦心. All rights reserved.
//

import UIKit
import MWFeedParser
import SnapKit
import SVProgressHUD

class MainViewController: UITableViewController,MWFeedParserDelegate {
    
    var url = NSURL()
    var items = [MWFeedItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedParser = MWFeedParser(feedURL: self.url)
        feedParser.delegate = self
        feedParser.feedParseType = ParseTypeItemsOnly
        feedParser.connectionType = ConnectionTypeAsynchronously
        feedParser.parse()
        
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
    }
    
//  MARK:UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel!.text = self.items[indexPath.row].title
        cell.textLabel!.numberOfLines = 2
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
//  MARK:UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = NSURL(string: self.items[indexPath.row].link)
        let c = WebViewController()
        c.url = url!
        c.navigationItem.title = "Reading"
        if let title = self.items[indexPath.row].title {
            print(title)
        }
        if let link = self.items[indexPath.row].link {
            print(link)
        }
        if let author = self.items[indexPath.row].author {
            print(author)
        }
        if let date = self.items[indexPath.row].date {
            print(date)
        }
        if let updated = self.items[indexPath.row].updated {
            print(updated)
        }
        if let summary = self.items[indexPath.row].summary {
            c.webView.loadHTMLString(summary, baseURL: url)
            print(summary)
        }
        if let content = self.items[indexPath.row].content {
            print(content)
        }
        if let enclosures = self.items[indexPath.row].enclosures {
            print(enclosures)
        }
        if let identifier = self.items[indexPath.row].identifier {
            print(identifier)
        }
        
        self.navigationController?.pushViewController(c, animated: true)
    }
    
//  MARK:MWFeedParserDelegate
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        self.items.append(item)
        self.tableView.reloadData()
    }
}

