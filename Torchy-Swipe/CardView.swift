//
//  CardStack.swift
//  Torchy
//
//  Created by Alex Cruz on 6/24/16.
//  Copyright © 2016 torchy. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var person: Person! {
        didSet {
            
            // Property Configuration
            imageView.image = person.image
            nameLabel.text = person.name
            ageLabel.text = String(person.age)
            
        }
    }
    
    // UIImage intializer
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let ageLabel = UILabel()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // fatalError("init(coder:) has not been implemented")
        defaultInit()
    }
    
    
    func defaultInit() {
        self.backgroundColor = UIColor.white
        
        // Loop through each view that we add it and make some property changes on those view
        for v in [imageView, nameLabel, ageLabel] {
            // set auto layout programmatically
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // Now that are subview are ready to layout, lets go through each one and lay them out individually
        
        // imageView
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        // HEIGHT - Now the height of the image View is going to be base on the current view size, so its going to be a % of the total view
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.9, constant: 0).isActive = true
        
        
        // Name
        NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        // Age
        NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: ageLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -7).isActive = true
        NSLayoutConstraint(item: ageLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        nameLabel.textAlignment = .left
        
        ageLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        ageLabel.textAlignment = .right
        
        
        // Styling
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        
    }
    
}
