//
//  SearchResultPromptCell.swift
//  WeChatSearchDemo
//
//  Created by 罗伟 on 2017/8/1.
//  Copyright © 2017年 rainedAllNight. All rights reserved.
//

import UIKit

class SearchResultPromptCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.hideSeparator()
    }

    func hideSeparator() {
        let screenWidth = UIScreen.main.bounds.width
        self.separatorInset = UIEdgeInsetsMake(0, screenWidth, 0, -screenWidth)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
