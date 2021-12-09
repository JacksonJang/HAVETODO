//
//  Extensions.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

//방향설정
func setOrientation(ori:UIInterfaceOrientationMask){
    if let delegate = UIApplication.shared.delegate as? AppDelegate {
        delegate.orientation = ori
    }
}

//설정창 이동
//func openAppSetting(){
//    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
//    
//    if UIApplication.shared.canOpenURL(url) {
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    }
//}
