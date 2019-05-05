//
//  FeedTableViewCell.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/25/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var contentLabel: UITextView!
    
    let padding: CGFloat = 18
    let nameLabelHeight: CGFloat = 16
    let contentLabelHeight: CGFloat = 140
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentLabel = UITextView()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.isEditable = false
        contentLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        contentLabel.layer.borderColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0).cgColor
        contentLabel.layer.borderWidth = 0.5
        contentLabel.layer.cornerRadius = 6
        contentView.addSubview(contentLabel)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textColor = UIColor(red: 255/255, green: 172/255, blue: 7/255, alpha: 1.0)
        contentView.addSubview(nameLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentLabel.heightAnchor.constraint(equalToConstant: contentLabelHeight),
            //contentLabel.widthAnchor.constraint(equalToConstant: 320)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding+4),
            nameLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 15),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])
    }
    
    func configure(for post: Posts){
        contentLabel.text = post.text
        nameLabel.text = post.nickname
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
