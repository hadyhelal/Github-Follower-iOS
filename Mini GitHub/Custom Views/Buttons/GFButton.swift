//
//  GFButton.swift
//  Mini GitHub
//
//  Created by Hady on 10/31/20.
//  Copyright © 2020 HadyOrg. All rights reserved.

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //handle init in storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(background : UIColor , title : String){
        super.init(frame: .zero)
        self.backgroundColor = background
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius    = 10
        titleLabel?.textColor = .white
        
        //use built in text style whenever possible
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // download semantic UI
        translatesAutoresizingMaskIntoConstraints = false //always set if to false
        
    }

}
