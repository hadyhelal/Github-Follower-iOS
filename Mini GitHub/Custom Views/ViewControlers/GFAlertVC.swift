//
//  GFAlertVC.swift
//  Mini GitHub
//
//  Created by Hady on 11/3/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {

    let containerView = UIView()
    let titleLabel    = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel  = GFBodyLabel(textAlignment: .center)
    let actionButton  = GFButton(background: .systemPink, title: "Ok")
    
    var alertTitle   : String?
    var messageTitle : String?
    var buttonTitle  : String?
    
    let padding : CGFloat = 20 //For Constraints
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title : String , message : String , buttonTitel : String){
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle    = title
        self.messageTitle  = message
        self.buttonTitle   = buttonTitel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    func configureContainerView(){
        
        view.addSubview(containerView)
        containerView.backgroundColor    = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth  = 2
        containerView.layer.borderColor  = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something Went Wrong!"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor , constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
    }
    
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok" , for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.numberOfLines = 4
        messageLabel.text = messageTitle ?? "WTF is Going On!"
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: -12)
        ])
    }
}
