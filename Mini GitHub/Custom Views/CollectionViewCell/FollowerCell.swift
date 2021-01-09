//
//  CollectionViewCell.swift
//  Mini GitHub
//
//  Created by Hady on 11/19/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseId = "FollowerCell"
    let avatarImage    =  GFAvatarImageView(frame: .zero)
    let userNameLabel  =  GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding : CGFloat = 8
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Follower){
        
        userNameLabel.text = follower.login
        avatarImage.downloadingImage(from: follower.avatarUrl)
    }
    
    private func configure(){
        addSubview(avatarImage)
        addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
