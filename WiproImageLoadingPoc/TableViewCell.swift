//
//  TableViewCell.swift
//  WiproImageLoadingPoc
//  Copyright © 2018 Vijay. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    let nameLabel = UILabel()
    let detailLabel = UILabel()
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        let marginGuide = contentView.layoutMarginsGuide
        
         // configure countryImageView
        contentView.addSubview(countryImageView)
        countryImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant:40).isActive = true
        countryImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor , constant:5).isActive = true
        countryImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        
        
        // configure nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant:8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        // configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant:8).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont(name: "Avenir-Book", size: 12)
        detailLabel.textColor = UIColor.lightGray
        countryImageView.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor).isActive = false
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
