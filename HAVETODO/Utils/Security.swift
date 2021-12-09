//
//  Security.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/02.
//

import UIKit

//탈옥 시 사용하는 앱이 설치되어있는지 확인하고 접근 불가한 경로를 열어보는 시도로 탈옥 여부 즉 루트 권한이 있는지 체크한다
//https://6developer.com/935
func hasJailbreak() -> Bool {
    guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return false }
    
    if UIApplication.shared.canOpenURL(cydiaUrlScheme as URL) {
        return true
    }
    #if arch(i386) || arch(x86_64)
    return false
    #endif
        
    let fileManager = FileManager.default
    
    if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
        fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        fileManager.fileExists(atPath: "/bin/bash") ||
        fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
        fileManager.fileExists(atPath: "/etc/apt") ||
        fileManager.fileExists(atPath: "/usr/bin/ssh") ||
        fileManager.fileExists(atPath: "/private/var/lib/apt") {
        return true
    }
    if canOpen(path: "/Applications/Cydia.app") ||
        canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        canOpen(path: "/bin/bash") ||
        canOpen(path: "/usr/sbin/sshd") ||
        canOpen(path: "/etc/apt") ||
        canOpen(path: "/usr/bin/ssh") {
        return true
    }
    let path = "/private/" + NSUUID().uuidString
    do {
        try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        try fileManager.removeItem(atPath: path)
        return true
    } catch {
        return false
    }
    
    /*
     // 탈옥 여부를 체크하고 루트권한이 있는 기기라면 다이얼로그를 띄우고 확인을 누르면 앱을 종료하는 예제
     if(hasJailbreak()){

                 let dialog = UIAlertController(title: nil, message: "루트권한을 가진 디바이스에서는 실행할 수 없습니다.", preferredStyle: .alert)
                 let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default){
                     (action:UIAlertAction!) in
                         exit(0)
                 }
                 dialog.addAction(action)
                 self.present(dialog, animated: true, completion: nil)


             }

     */
}

func canOpen(path: String) -> Bool {
    let file = fopen(path, "r")
    guard file != nil else { return false }
    fclose(file)
    return true
}
