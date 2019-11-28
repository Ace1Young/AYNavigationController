//
//  ThirdViewController.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/25.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func action(_ sender: UIButton) {
        (self.navigationController as! AYNavigationController).push(vc: FourthViewController(), style: .defaultStyle)
    }
}
