//
//  NewViewController.swift
//  ScrollButton
//
//  Created by Рома on 06.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    var panGesturePoint: CGPoint?
    var lastRotation   = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstImage.isUserInteractionEnabled = true
        secondImage.isUserInteractionEnabled = true
        secondImage.isMultipleTouchEnabled = true
        
        let panRecognizer = UIPanGestureRecognizer (target: self, action: #selector(Pan(_:)))
        firstImage.addGestureRecognizer(panRecognizer)
        
        let rotationRecognizer = UIRotationGestureRecognizer (target: self, action: #selector(rotation(_:)))
        secondImage.addGestureRecognizer(rotationRecognizer)
        
        
        let pinchRecognizer = UIPinchGestureRecognizer (target: self, action: #selector(pinch(_:)))
        secondImage.addGestureRecognizer(pinchRecognizer)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(firstImageTapped(_:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(firstImageLongPress(_:)))
        
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        firstImage.addGestureRecognizer(tapGesture)
        
        firstImage.addGestureRecognizer(longPressGesture)

    }
    
    
    @objc func Pan(_ gestureRecognizer: UIPanGestureRecognizer) {
      switch gestureRecognizer.state {
      case .began:
          if panGesturePoint == nil {
              panGesturePoint = firstImage.center
          }
          break
        
      case .changed:
        let translation = gestureRecognizer.translation(in: view)
        
        firstImage.center = CGPoint(x: firstImage.center.x + translation.x,
                                  y: firstImage.center.y + translation.y)
        
        gestureRecognizer.setTranslation(.zero, in: view)
        
        break
     
    default:
        break
        }
    }
    
    @objc func pinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        self.view.bringSubviewToFront(secondImage)
           gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
           gestureRecognizer.scale = 1.0
        
    }
    
    @objc func rotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        self.view.bringSubviewToFront(secondImage)
        if(gestureRecognizer.state == UIGestureRecognizer.State.ended){
            lastRotation = 0.0;
        }
        let rotation = 0.0 - (lastRotation - gestureRecognizer.rotation)
        let currentTrans = gestureRecognizer.view?.transform
        let newTrans = currentTrans!.rotated(by: rotation)
        gestureRecognizer.view?.transform = newTrans
        lastRotation = gestureRecognizer.rotation
    }
    
    @objc func firstImageTapped(_ gestureRecognizer: UITapGestureRecognizer) {

        if self.firstImage.layer.cornerRadius == 0 {
            self.firstImage.layer.cornerRadius = 20
        }else{
            self.firstImage.layer.cornerRadius = 0
        }
    }
    
    @objc func firstImageLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "Long Press", message: "Long press gesture called when you press on view of 1 second duration.", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert) in
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}
