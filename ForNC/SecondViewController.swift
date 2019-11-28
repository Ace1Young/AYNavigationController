//
//  SecondViewController.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/21.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second"
        let nameArr = ["Second", "Second", "Second", "Second", "Second", "Second", "Second", "Second", "Second"]
        let but = UIButton(frame: CGRect(x: 30, y: 100, width: 80, height: 80))
        but.backgroundColor = .red
        but.addTarget(self, action: #selector(test), for: .touchUpInside)
        
        let but2 = UIButton(frame: CGRect(x: 30, y: 200, width: 80, height: 80))
        but2.backgroundColor = .gray
        but2.addTarget(self, action: #selector(test2), for: .touchUpInside)
        view.addSubview(but2)
        
        let sv = UIScrollView(frame: CGRect(x: 30, y: 300, width: 300, height: 44))
        sv.backgroundColor = .cyan
        
        for index in 0...8 {
            var labelW: CGFloat = 0
            var x: CGFloat = 0
            let label = UILabel()
            label.text = nameArr[index]
            labelW = max(labelW, label.intrinsicContentSize.width)
            x = (x + labelW + 8) * CGFloat(index)
            label.frame = CGRect(x: x, y: 0, width: labelW, height: 44)
            sv.contentSize = CGSize(width: (labelW * CGFloat(nameArr.count) + 70), height: 44)
            sv.addSubview(label)
        }
        
        view.addSubview(but)
        view.addSubview(but2)
        view.addSubview(sv)
        
        self.addRightBarItem(action: #selector(test), title: nil, image: UIImage(named: "mine_a06"))
    }
    
    @objc func test() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func test2() {
        (self.navigationController as! AYNavigationController).push(vc: ThirdViewController(), style: .mainStyle)
    }
}
