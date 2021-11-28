//
//  Storyboarded.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

protocol Storyboarded {
    static var storyboardName:String { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
