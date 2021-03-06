//
//  UIViewController+Extensions.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

extension UIViewController {
    static func loadNib() -> Self {
        return Self.init(nibName: String(describing: Self.self), bundle: Bundle.init(for: Self.self))
    }
    
    func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func getRootNaviVC() -> UINavigationController? {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            return rootVC
        }
        return nil
    }
    
    func goNaviTo(_ vc:UIViewController, animated: Bool = true)  {
        if let naviVC = self.getRootNaviVC() {
            naviVC.pushViewController(vc, animated: animated)
            
            if vc.isKind(of: MainVC.self) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                //메인으로 갈때는 무조건 이전 VC들 삭제
                    naviVC.viewControllers.removeAll(where:{ (subVC) -> Bool in
                        if subVC.isKind(of: MainVC.self) {
                            return false
                        } else {
                            return true
                        }
                    })
                }
            }
            
        }
    }
    
}
