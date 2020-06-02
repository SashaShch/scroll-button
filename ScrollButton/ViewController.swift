//
//  ViewController.swift
//  ScrollButton
//
//  Created by Рома on 02.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scView:UIScrollView!
    let buttonPadding:CGFloat = 70
    var xOffset:CGFloat = 0
    var photoView: UIView!
    let coloros: [UIColor] = [.red, .brown, .green, .orange, .purple]
    let titles: [String] = ["red", "brown", "green", "orange", "purple"]

    override func viewDidLoad() {
        super.viewDidLoad()
        scView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 120))
        view.addSubview(scView)

        scView.backgroundColor = UIColor.lightGray
        scView.translatesAutoresizingMaskIntoConstraints = false
        
        photoView = UIView(frame: CGRect(x: 0, y: scView.frame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - scView.frame.height))
        photoView.backgroundColor = coloros[0]
        view.addSubview(photoView)

        for i in 0 ... 4 {
            let button = UIButton()
            button.tag = i
            button.backgroundColor = coloros[i]
            button.setTitle("\(titles[i])", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControl.Event.touchUpInside)

            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 100, height: 50)

            xOffset = xOffset +  button.frame.size.width
            scView.addSubview(button)
        }

        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
    
    @objc func btnTouch(_ sender : UIButton) {
        photoView = UIView(frame: CGRect(x: 0, y: scView.frame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - scView.frame.height))
        photoView.backgroundColor = coloros[sender.tag]
        view.addSubview(photoView)
    }
}

