//
//  ViewController.swift
//  TblRelayout-Swift
//
//  Created by Cindy on 2018/12/28.
//  Copyright © 2018年 Cindy. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController {

    let defaultH:CGFloat = 224.0
    var heightMap: [String: CGFloat] = [:]
    var urlList:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlList.append("https://dl.dropboxusercontent.com/s/vjsvhwljobezz20/27216462-square-wallpapers.jpg")
        urlList.append("https://dl.dropboxusercontent.com/s/lcwjp9fwocofg2u/1483393900304.jpg");
        urlList.append("https://dl.dropboxusercontent.com/s/2qbxqnr1l8q7mia/oie_8IWPRCm-16x40.jpg");
        urlList.append("https://dl.dropboxusercontent.com/s/v5ukpp8lmphbg2o/w2izN1600x1700.jpg");
        urlList.append("https://dl.dropboxusercontent.com/s/pc48489vipxmxgh/giphy-7.gif");
        urlList.append("https://dl.dropboxusercontent.com/s/xz34okugp614lpk/oceanside-cliffs-of-ireland_925x.jpg");
        urlList.append("https://dl.dropboxusercontent.com/s/4v34f8ycxvqfm14/dropbox_vlg_arch_01_05_interiordeco_bedroom01.png");
        urlList.append("https://dl.dropboxusercontent.com/s/27th3kbv343issp/giphy-1.gif");
 
        tableView.register(UINib(nibName: "TTableViewCell", bundle: nil), forCellReuseIdentifier: "TTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let h = heightMap[String(format: "%d", indexPath.row)] else
        {
            return defaultH
        }
        return h
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TTableViewCell") as! TTableViewCell
        
        let url = URL(string:urlList[indexPath.row])
        cell.imgview.kf.indicatorType = .activity
        cell.imgview.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (_ image: Image?, _ error:NSError?,
            _ cacheType:CacheType, _ imageURL: URL?) in
            if (image != nil)
            {
                print(indexPath.row, cacheType)
                self.configHeight(row: indexPath.row, image: image!)
            }
        }
        return cell
    }
    
    func configHeight(row:Int, image:Image) -> Void {
        let ratio:CGFloat = image.size.height / image.size.width
        heightMap[String(format: "%d", row)] = UIScreen.main.bounds.size.width * ratio
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
    }
}

