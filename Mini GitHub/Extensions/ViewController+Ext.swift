//
//  ViewController+Ext.swift
//  Mini GitHub
//
//  Created by Hady on 11/3/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

fileprivate var containerView : UIView!
extension UIViewController {
    
    func presentGFAlertOnMainThread(title : String , message : String , buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitel: buttonTitle)
            alertVC.modalPresentationStyle = .fullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        view.backgroundColor = .systemBackground
        containerView.alpha  = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(message : String , in view : UIView){
        let emptyState = GFEmptyStateView(message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
}
