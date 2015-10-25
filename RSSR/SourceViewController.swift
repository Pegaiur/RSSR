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

struct RRSourceComplex {
    var title = ""
    var url = NSURL()
}

class SourceViewController: UITableViewController,MWFeedParserDelegate {
    
    var sources = [RRSourceComplex]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sources.append(RRSourceComplex())
        self.sources[0].url = NSURL(string: "http://www.zhihu.com/rss")!
        for source in sources {
            let feedParser = MWFeedParser(feedURL: source.url)
            feedParser.delegate = self
            feedParser.feedParseType = ParseTypeInfoOnly
            feedParser.connectionType = ConnectionTypeAsynchronously
            feedParser.parse()
        }
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
//  MARK:MWFeedParserDelegate
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        for var i = 0;i < sources.count;i++ {
            if self.sources[i].url == parser.url {
                self.sources[i].title = info.title
                self.tableView.reloadData()
            }
        }
    }

    func feedParser(parser: MWFeedParser!, didFailWithError error: NSError!) {
        if let e = error {
            SVProgressHUD.showErrorWithStatus("\(e.code)")
        }
    }
}
