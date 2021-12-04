//
//  Authentication.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/03.
//

import UIKit
import LocalAuthentication

extension UIViewController {
    
    
    //FACE ID 생체인식
    func localAuthentication() -> Void {
        print("localAuthentication()")
        let laContext = LAContext()
        var error: NSError?
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics

        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            if let laError = error {
                print("laError - \(laError)")
                return
            }

            var localizedReason = "Unlock device"
            
            if #available(iOS 11.0, *) {
                if (laContext.biometryType == LABiometryType.faceID) {
                    localizedReason = "Unlock using Face ID"
                    print("FaceId support")
                } else if (laContext.biometryType == LABiometryType.touchID) {
                    localizedReason = "Unlock using Touch ID"
                    print("TouchId support")
                } else {
                    print("No Biometric support")
                }
            } else {
                // Fallback on earlier versions
            }
            
            laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                
                DispatchQueue.main.async(execute: {
                    if let laError = error {
                        print("laError - \(laError)")
                    } else {
                        if isSuccess {
                            print("sucess")
                        } else {
                            print("failure")
                        }
                    }

                })
            })
        }
    }
}
