//
//  CardStack.swift
//  Torchy
//
//  Created by Alex Cruz on 6/24/16.
//  Copyright © 2016 torchy. All rights reserved.
//

import UIKit

class CardStack: UIView {
    
    // Add initializers
    
    // This is base on how it class and subclass initializers relate to its super class
    
    
    // Add Array of card view
   var cards: [CardView] = []
    
    
    
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
        // Here we add our ppl, this should be done in the ViewController
        
        for person in people {
           addPerson(person)
        }
        
    }
    
    
    func addPerson(_ person: Person) {
        
        // Add card to our card stack
        // Create a new card for each person
        let card = CardView()
        card.person = person
        
    
        
        self.addSubview(card)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: card, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        cards.append(card)
        
        self.sendSubview(toBack: card)
        
        setupTransforms(0)
        
        // Here we will be adding gesture recognizer
        if cards.count == 1 {
            card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(CardStack.pan(_:))))
        }
        
        
    }
    
    // Now setup transform should go through each of the cards and configure the transform so that they layout correctly
    // That means the first view is not going to move and the one under is going to be slightly tilted to the left or right
    
    func setupTransforms(_ percentCompletion: Double) {
        // Iterate through the cards
        let translationDelta: CGFloat = 6
        
        for (i, card) in cards.enumerated() {
            if i == 0 { continue; }
            
            
            
            var translationA, rotationA, scaleA: CGFloat!
            var translationB, rotationB, scaleB: CGFloat!
            
            
            if i % 2 == 0 {
                translationA = CGFloat(i)*translationDelta
                rotationA = CGFloat(M_PI)/100*CGFloat(i)
                
                translationB = -CGFloat(i-1)*translationDelta
                rotationB = -CGFloat(M_PI)/100*CGFloat(i-1)
            } else {
                translationA = -CGFloat(i)*translationDelta
                rotationA = -CGFloat(M_PI)/100*CGFloat(i)
                
                translationB = CGFloat(i-1)*translationDelta
                rotationB = CGFloat(M_PI)/100*CGFloat(i-1)
            }
            
            scaleA = 1-CGFloat(i)*0.05
            scaleB = 1-CGFloat(i-1)*0.05
            
            let translation = translationA*(1-CGFloat(percentCompletion))+translationB*CGFloat(percentCompletion)
            let rotation = rotationA*(1-CGFloat(percentCompletion))+rotationB*CGFloat(percentCompletion)
            
            let scale = scaleA*(1-CGFloat(percentCompletion))+scaleB*CGFloat(percentCompletion)
            
            
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: translation, y: 0)
            transform = transform.rotated(by: rotation)
            transform = transform.scaledBy(x: scale, y: scale)
            
            card.transform = transform

            
            
        }
        
    }
    
    func pan(_ gesture: UIPanGestureRecognizer) {
        // Lets cast the view that owns this gesture
        let card = gesture.view! as! CardView
        
        let translation = gesture.translation(in: self)
        
        // Calculate the % completion
        var percent = translation.x / self.bounds.midX
        percent = min(percent, 1)
        percent = max(percent, -1)
        
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations:
            {
               self.setupTransforms(abs(Double(percent)))
            }, completion: nil)
        
        
        
        // Add rotation
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: translation.x, y: translation.y)
    //    print("First \(transform)")
        transform = transform.rotated(by: CGFloat(M_PI)*percent/30)
   //     print("Second \(transform)")
        card.transform = transform
        
        
        
       
        card.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        
        // Return card to starting point
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [],
                                       
                animations: {
                    
                    card.transform = CGAffineTransform.identity
                
                }, completion: nil)
                
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations:
                {
                    self.setupTransforms(0)
                }, completion: nil)
        }
        
    }
    
}
