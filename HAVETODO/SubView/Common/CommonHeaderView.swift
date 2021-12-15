//
//  CommonHeaderView.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/13.
//

import UIKit

class CommonHeaderView : UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        
        guard let customView = nibs?.first as? UIView else {return}
        customView.frame = self.bounds
        self.addSubview(customView)
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.autoresizesSubviews = true
    }
}
