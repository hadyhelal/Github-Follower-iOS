//
//  UserInfoVC.swift
//  Mini GitHub
//
//  Created by Hady on 1/6/21.
//  Copyright © 2021 HadyOrg. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var userName : String!
    var headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self , action: #selector(dismissVC) )
        navigationItem.rightBarButtonItem = barButton
        
        layoutHeaderView()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
             
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), in: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went Wrong!", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }


    func add(childVC : UIViewController , in containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutHeaderView(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
