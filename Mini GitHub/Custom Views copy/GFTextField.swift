//
//  GFTextField.swift
//  Mini GitHub
//
//  Created by Hady on 10/31/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray2.cgColor // for core graphics
        
        
        textColor     = .label // white in normal black in night mode
        tintColor     = .label
        textAlignment = .center
        font          = UIFont.preferredFont(forTextStyle: .title2)
        
        adjustsFontSizeToFitWidth = true
        
        minimumFontSize    = 12
        returnKeyType      = .go
        backgroundColor    = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter thr User name"
    }
}
