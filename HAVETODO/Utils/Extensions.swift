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
func openAppSetting(){
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

//오늘 날짜 구하기
func getTodayDate() -> String {
    let today = Date() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "YYYYMMddHHmmss"
    
    let dateString = dateFormatter.string(from: today)
    
    return dateString
}

func getTodayYear() -> String {
    let today = Date() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "YYYY"
    
    let dateString = dateFormatter.string(from: today)
    
    return dateString
}

func getTodayMonth() -> String {
    let today = Date() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "MM"
    
    let dateString = dateFormatter.string(from: today)
    
    return dateString
}

func getTodayDay() -> String {
    let today = Date() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "dd"
    
    let dateString = dateFormatter.string(from: today)
    
    return dateString
}

