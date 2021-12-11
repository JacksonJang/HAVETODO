//
//  MemoListView.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/05.
//

/*
 
 UITableView Editing Mode 관련 내용
 https://furang-note.tistory.com/11
 
 UITableView Drag & Drop으로 Row 이동
 https://furang-note.tistory.com/31
 
 */

import UIKit

class MemoListVC: BaseViewController, Storyboarded {
    static var storyboardName: String = String(describing: MemoListVC.self)
    
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = []
    var headerView:MemoListHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.register(UINib(nibName: "MemoListCell", bundle: nil), forCellReuseIdentifier: "MemoListCell")
        tableView.register(UINib(nibName: "MemoListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MemoListHeaderView")
        
        setupUI()
    }
    
    func setupUI() {
        var i = 0
        while(i < 10){
            self.data.append("test")
            i += 1
        }
        
        tableView.reloadData()
    }
    @IBAction func onTouchAddingMemo(_ sender: Any) {
        print("onTouchAddingMemo")
    }
}

extension MemoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as! MemoListCell
        
        cell.titleLabel.text = data[indexPath.row] + String(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = self.data[sourceIndexPath.row]
        self.data.remove(at: sourceIndexPath.row)
        self.data.insert(moveCell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MemoListHeaderView") as! MemoListHeaderView

        headerView.testLabel.text = "\(section)"
        
        return headerView
    }
    
}

// MARK:- UITableView UITableViewDragDelegate
extension MemoListVC: UITableViewDragDelegate {
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
 
// MARK:- UITableView UITableViewDropDelegate
extension MemoListVC: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}
