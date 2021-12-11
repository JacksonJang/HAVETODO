//
//  MemoListHeaderView.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/11.
//

import UIKit

class MemoListHeaderView : UITableViewHeaderFooterView {
    @IBOutlet weak var testLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.testLabel.text = ""
    }
}
