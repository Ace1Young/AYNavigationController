//
//  FourthViewController.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/26.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var v: UIView!
    @IBOutlet weak var heightCon: NSLayoutConstraint!
    @IBOutlet weak var but: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fourth"
        
        let but = UILabel()
        but.text = "1"
        
        let but2 = UILabel()
        but2.text = "2"
        
        let sv = UIStackView(arrangedSubviews: [but, but2])
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 0
        sv.axis = .vertical
        
        self.navigationItem.titleView = sv
        
        let path = UIBezierPath(roundedRect: v.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 16, height: 16))
        let layer = CAShapeLayer()
        layer.frame = v.bounds
        layer.path = path.cgPath
        v.layer.mask = layer
        
        let path2 = UIBezierPath(roundedRect: but.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.bottomLeft.rawValue), cornerRadii: CGSize(width: 8, height: 8))
        let layer2 = CAShapeLayer()
        layer2.frame = but.bounds
        layer2.path = path2.cgPath
        but.layer.mask = layer2
    }
    
    @IBAction func action(_ sender: UIButton) {
//        for vc in self.navigationController!.viewControllers {
//            if vc is SecondViewController {
//                self.navigationController?.popToViewController(vc, animated: true)
//            }
//        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
