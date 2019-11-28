//
//  AYNavigationController.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/21.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

class AYNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    enum NavigationBarStyle {
        /// 这里可以是任何的样式
        case defaultStyle
        /// App 的主要样式
        case mainStyle
        /// 隐藏且状态栏是黑字
        case hiddenAndBlackStyle
        /// 隐藏且状态栏是白字
        case hiddenAndLightStyle
    }
    
    /// 记录堆栈内对应VC的navBar样式
    var navigationBarStyleArr: [NavigationBarStyle] = []
    /// true 时用于在根视图控制器的导航栏上显示返回按钮
    var isPresented = false
        
    /// 自定义的初始化方法
    init(rootVC: UIViewController, style: NavigationBarStyle) {
        super.init(nibName: nil, bundle: nil)
        navigationBarStyleArr.append(style)
        self.addChild(rootVC)
        setNavigationBar(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        
        if self.isPresented == true, let firstVC = self.viewControllers.first, let lastStyle = navigationBarStyleArr.last {
            firstVC.navigationItem.leftBarButtonItem = setBackItem(lastStyle)
        }
    }
    
    /// 在 navigationcontroller 的 rootvc 时，禁止右滑。
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        } else {
            return true
        }
    }
    
    /// 设置导航栏的样式
    func setNavigationBar(style: NavigationBarStyle) {
        switch style {
        case .defaultStyle:
            self.navigationBar.isHidden = false
            self.navigationBar.barTintColor = UIColor.blue
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            statusBarStyle = .default
            
        case .mainStyle:
            self.navigationBar.isHidden = false
            self.navigationBar.barTintColor = UIColor.red
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            statusBarStyle = .lightContent
            
        case .hiddenAndBlackStyle:
            self.navigationBar.isHidden = true
            statusBarStyle = .default
            
        case .hiddenAndLightStyle:
            self.navigationBar.isHidden = true
            statusBarStyle = .lightContent
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - PUSH、POP
extension AYNavigationController {
    
    func push(vc: UIViewController, style: NavigationBarStyle, isTabbarHidden: Bool = true) {
        navigationBarStyleArr.append(style)
        vc.hidesBottomBarWhenPushed = isTabbarHidden
        pushViewController(vc, animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这行的顺序很重要，不然没有用
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
        /// 设置导航栏返回按钮
        if self.children.count > 1, let style = navigationBarStyleArr.last {
            viewController.navigationItem.leftBarButtonItem = setBackItem(style)
        }
        /// 不转换直接成该导航控制器直接 PUSH 时会用到这里，不然就崩溃，或者每次调用时都转换成该控制器再 PUSH
        if self.viewControllers.count != navigationBarStyleArr.count {
            navigationBarStyleArr.append(navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
        }
        setNavigationBar(style: navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: true)
        let last = navigationBarStyleArr.last
        
        navigationBarStyleArr.removeLast()
        setNavigationBar(style: navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
        /// 解决右滑不彻底时而出现的 bug
        if let tor = transitionCoordinator, let la = last {
            tor.animate(alongsideTransition: nil) { (_) in
                if self.viewControllers.count != self.navigationBarStyleArr.count {
                    self.navigationBarStyleArr.append(la)
                }
                self.setNavigationBar(style: self.navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
            }
        }
        return vc
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated)
        if vcs != nil {
            for _ in 0...vcs!.count - 1 {
                navigationBarStyleArr.removeLast()
            }
        }
        setNavigationBar(style: navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
        return vcs
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcArr = super.popToRootViewController(animated: animated)
        
        if vcArr != nil {
            for _ in 0...vcArr!.count - 1 {
                navigationBarStyleArr.removeLast()
            }
        }
        setNavigationBar(style: navigationBarStyleArr.last ?? NavigationBarStyle.mainStyle)
        return vcArr
    }
    
    /// 设置导航栏返回按钮
    func setBackItem(_ style: NavigationBarStyle) -> UIBarButtonItem {
        let buton = UIButton(type: .custom)
        buton.setTitle(nil, for: .normal)
        buton.sizeToFit()
        buton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        switch style {
        case .defaultStyle, .mainStyle:
            buton.setImage(UIImage(named: "mine_a24"), for: .normal)
        default:
            break
        }
        
        let item = UIBarButtonItem(customView: buton)
        return item
    }
    
    @objc func backAction() {
        if isPresented, self.viewControllers.count == 1 {
            dismiss(animated: true, completion: nil)
            
        } else {
            _ = popViewController(animated: true)
        }
    }
}

extension UIViewController {
    /// 给 VC 单加单个 rightItem
    func addRightBarItem(action: Selector, title: String?, image: UIImage?) {
        let item = UIBarButtonItem(customView: customView(target: self, action: action, title: title, image: image))
        self.navigationItem.rightBarButtonItem = item
    }
    
    func customView(target: Any, action: Selector, title: String?, image: UIImage?) -> UIView {
        let button = UIButton(type: .custom)
        /// 既有文字又有图片
        if let title = title, let image = image {
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
        }
        /// 只有文字
        if let title = title, image == nil {
            button.setTitle(title, for: .normal)
        }
        /// 只有图片
        if title == nil, let image = image {
            button.setImage(image, for: .normal)
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }
}
