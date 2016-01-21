//
//  InformationTVCell.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/20/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit

class InformationTVCell: UITableViewCell {

    @IBOutlet var magLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
