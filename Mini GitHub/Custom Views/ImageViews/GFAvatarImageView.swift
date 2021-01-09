//
//  GFAvatarImageView.swift
//  Mini GitHub
//
//  Created by Hady on 11/19/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImage = UIImage(named: "avatar-placeholder")
    let cach             = NetworkManager.shared.cache
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadingImage(from urlString : String){
        //First of all check if the image already existed in the cach
        let cachKey = NSString(string: urlString)
        
        if let image = cach.object(forKey: cachKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return}
        

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self     = self else { return }
            if error           != nil {return}
            guard let data     = data else {return}
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {return}
            guard let image    = UIImage(data: data) else {return;}
            
            self.cach.setObject(image, forKey: cachKey)
            DispatchQueue.main.async {
                self.image = image
                print("Done")
            }
        }
        task.resume()
    }
}
