//
//  AnimationViewController.swift
//  ScrollButton
//
//  Created by Рома on 21.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.layer.cornerRadius = 10
        
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 5, height: 10)
        textField.layer.shadowRadius = 25
        textField.layer.shadowOpacity = 1
        
        doneButton.layer.cornerRadius = 10
        
        doneButton.layer.borderColor = UIColor.white.cgColor
        doneButton.layer.borderWidth = 2
        
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOffset = CGSize(width: 5, height: 10)
        doneButton.layer.shadowRadius = 25
        doneButton.layer.shadowOpacity = 1
        
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.repeatCount = 10000
        animation.duration = 4
        animation.values = [1, 0, 1]
        
        imageView.layer.add(animation, forKey: "opacity-animation")
    }

    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let text = textField.text {
            if text.count < 6 {
                let animation = CAKeyframeAnimation(keyPath: "position")
                animation.repeatCount = 10
                animation.duration = 0.1
                animation.values = [CGRect(x: textField.center.x - 5, y: textField.center.y, width: textField.frame.width, height: textField.frame.height),
                                    CGRect(x: 5 + textField.center.x, y: textField.center.y, width: textField.frame.width, height: textField.frame.height),]
                
                
                self.textField.layer.add(animation, forKey: "shake-animation")
            } else {
                view.endEditing(true)
            }
        }
    }
}
