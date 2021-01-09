//
//  SearchVC.swift
//  Mini GitHub
//
//  Created by Hady on 10/30/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView      = UIImageView()
    let userNameTextField  = GFTextField()
    let callToActionButton = GFButton(background: .systemGreen, title: "Get Followers")

    var isUsernameEntered : Bool {
        return !userNameTextField.text!.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true , animated : true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configTextField()
        configcallToActionButton()
        tapGestureWhereverInTheScreen()
    }
    
    
    func tapGestureWhereverInTheScreen(){
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    
    @objc func goToVC(){
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty User Name", message: "Please Enter a username we need to know who to look for😊.", buttonTitle: "OK")
            //cmd + ctrl + SpaceBar to pop up an emoji list
            return
        }
        
        let followerList = FollowerListVC()
        followerList.userName = userNameTextField.text!
        followerList.title    = userNameTextField.text
        navigationController?.pushViewController(followerList, animated: true)
    }
    
    //MARK: - SetUp UI Constraints
    
    func configureLogoImage(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 88),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)

        ])
    }
    
    
    func configTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    func configcallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(goToVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
}

extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goToVC()
        return true
    }
}
