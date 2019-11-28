//
//  FirstViewController.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/21.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        let but = UIButton(frame: CGRect(x: 30, y: 200, width: 80, height: 80))
        but.backgroundColor = .red
        but.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.addSubview(but)
    }
    
    @objc func test() {
//        self.navigationController?.pushViewController(SecondViewController(), animated: true)
        (self.navigationController as! AYNavigationController).push(vc: SecondViewController(), style: .mainStyle)
    }
}
