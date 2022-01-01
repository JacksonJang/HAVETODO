//
//  SplashVC.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

class SplashVC: BaseViewController, Storyboarded {
    static var storyboardName: String = String(describing: SplashVC.self)
    
    @IBOutlet var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getTodayDate())
    }
    
    @IBAction func onTouchTest(_ sender: UIButton) {
        //TODO: 정상 로직시 주석 해제
//        goNaviTo(MainVC.instantiate())
        
        goNaviTo(MemoListVC.loadNib())
        
    }
}
