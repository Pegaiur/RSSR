//
//  SourceViewController.swift
//  RSSR
//
//  Created by 李锦心 on 15/10/25.
//  Copyright © 2015年 李锦心. All rights reserved.
//

import UIKit
import MWFeedParser
import SVProgressHUD
import YNLib

struct RRSourceComplex {
    var title = ""
    var url = NSURL()
}

class SourceViewController: UITableViewController,MWFeedParserDelegate {
    
    var sources = [RRSourceComplex]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "R S S R"
        
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        
        self.checkUpdateStatus()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func checkUpdateStatus() {
        if let context = CoreDataManager.sharedManager.mainContext {
            let sources = CoreDataHelper.getManagedObjects(CDSource.self, context: context)
            
            if sources.count < 5 {
                
                
                for _ in 0...4 {
                    self.sources.append(RRSourceComplex())
                }
                self.sources[0].url = NSURL(string: "http://www.zhihu.com/rss")!
                self.sources[1].url = NSURL(string: "http://feeds.feedburner.com/zhihu-daily")!
                self.sources[2].url = NSURL(string: "http://v2ex.com/feed/tab/tech.xml")!
                self.sources[3].url = NSURL(string: "http://techcrunch.cn/feed/")!
                self.sources[4].url = NSURL(string: "http://www.theverge.com/tech/rss/index.xml")!
                for source in self.sources {
                    let feedParser = MWFeedParser(feedURL: source.url)
                    feedParser.delegate = self
                    feedParser.feedParseType = ParseTypeInfoOnly
                    feedParser.connectionType = ConnectionTypeAsynchronously
                    feedParser.parse()
                }
                SVProgressHUD.show()
            } else {
                
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = self.sources[indexPath.row].title
        return cell
    }
    
//  MARK:UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let c = MainViewController()
        c.navigationItem.title = self.sources[indexPath.row].title
        c.url = self.sources[indexPath.row].url
        let feedParser = MWFeedParser(feedURL: c.url)
        feedParser.delegate = c
        feedParser.feedParseType = ParseTypeItemsOnly
        feedParser.connectionType = ConnectionTypeAsynchronously
        feedParser.parse()
        self.navigationController?.pushViewController(c, animated: true)
    }
    
//  MARK:MWFeedParserDelegate
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        for var i = 0;i < sources.count;i++ {
            if self.sources[i].url == parser.url {
                self.sources[i].title = info.title
                self.tableView.reloadData()
                if let context = CoreDataManager.sharedManager.mainContext {
                    let source = CoreDataHelper.createEntityForClass(CDSource.self, context: context)
                    source.title = info.title
                    source.link = info.link
                    source.summary = info.summary
                    source.lastUpdateTime = NSDate()
                    context.saveIgnoreErrorWithParentContextAndWait()
                }
            }
        }
        var finished = false
        for source in self.sources {
            if source.title != "" {
                finished = true
            } else {
                finished = false
                return
            }
        }
        if finished {
            SVProgressHUD.dismiss()
        }

    }

    func feedParser(parser: MWFeedParser!, didFailWithError error: NSError!) {
        if let e = error {
            SVProgressHUD.showErrorWithStatus("\(e)")
        }
    }
}
