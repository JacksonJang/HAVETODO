//
//  BaseViewController.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setOrientation(ori: [.portrait])
    }
    
    func addSubViews( _ subView :UIView...) {
        subView.forEach {self.view.addSubview($0)}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
