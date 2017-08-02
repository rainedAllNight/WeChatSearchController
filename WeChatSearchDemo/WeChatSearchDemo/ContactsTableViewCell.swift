//
//  ContactsTableViewCell.swift
//  WeChatSearchDemo
//
//  Created by 罗伟 on 2017/8/1.
//  Copyright © 2017年 rainedAllNight. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(_ contactModel: ContactModel) {
        self.nameLabel.text = contactModel.name
        self.avatarImageView.image = UIImage(named: contactModel.avatarUrl)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
