//
//  CommonHeaderView.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/13.
//

import UIKit

class CommonHeaderView : UIView {
    
    @IBOutlet var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("CommonHeaderView", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.autoresizesSubviews = true
    }
}
