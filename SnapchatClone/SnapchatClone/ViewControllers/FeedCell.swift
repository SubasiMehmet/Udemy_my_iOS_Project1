//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 22.04.2022.
//

import UIKit

class FeedCell: UITableViewCell {


    
    static let identifier = "Cell"

    
     let FeedImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "select")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
     let FeedUserNameLabel : UILabel = {
       let label = UILabel()
        //label.text = "Name"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(FeedUserNameLabel)
        contentView.addSubview(FeedImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        FeedUserNameLabel.frame = CGRect(x: 0,
                                         y: 10,
                                         width: contentView.frame.size.width,
                                         height: 30)
        
        FeedUserNameLabel.textAlignment = .center
        
        
        self.contentView.bringSubviewToFront(FeedUserNameLabel)
       
        
        FeedImageView.frame = CGRect(x: 10,
                                     y: FeedUserNameLabel.frame.maxY + 10,
                                     width: contentView.frame.size.width - 20,
                                     height: contentView.frame.size.width * 0.9)
        
    }
    
}
