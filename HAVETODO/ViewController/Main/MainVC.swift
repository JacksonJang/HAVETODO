//
//  MainVC.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/05.
//

import UIKit

class MainVC: BaseViewController, Storyboarded, UIGestureRecognizerDelegate {
    static var storyboardName: String = String(describing: MainVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //뒤로가기 스와이프 적용
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
