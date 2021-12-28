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

struct MemoList: Codable {
    var data:[[Memo]]
}

struct Memo: Codable {
    var title:String
    
    //TODO: 앞으로 추가할 속성들임
//    var content:String
//    var priority:String
//    var createDate:String
//    var updateDate:String
    
}

class MemoListVC: BaseViewController, Storyboarded {
    static var storyboardName: String = String(describing: MemoListVC.self)
    
    @IBOutlet var tableView: UITableView!
    
    //TODO: jsonString은 테스트 데이터이니 삭제해야함
    var jsonString = """
                     {
                        "data" : [
                            [{"title" : "test1"}],
                            [{"title" : "test2"}],
                            [{"title" : "test3"}]
                        ]
                     }
                    """
    
    
    var data: [[Memo]] = []
    var arrTitleList:[String] = [] //타이틀 리스트 (매일반복, 오늘, 기한이 지난 일)
    var strTodayTitle:String = "" //헤더 오늘 날짜값
    
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
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let memoList = try? decoder.decode(MemoList.self, from: jsonData)
        
        for item in memoList!.data {
            data.append(item)
        }
        
        setupData()
        setupUI()
    }
    
    func setupUI() {
        
        tableView.reloadData()
    }
    
    func setupData() {
        arrTitleList.removeAll()
        
        let year = getTodayYear()
        let month = getTodayMonth()
        let day = getTodayDay()
        
        //형식 : 오늘 (2021년 12월 10일 금요일)
        strTodayTitle = "오늘 (\(year)년 \(month)월 \(day)일 \(getWeekDay(atYear: Int(year)!, atMonth: Int(month)!, atDay: Int(day)!))요일)"
        
        arrTitleList.append("매일 반복")
        arrTitleList.append(strTodayTitle)
        arrTitleList.append("기한이 지난 일")
    }
    
    @IBAction func onTouchAddingMemo(_ sender: Any) {
        print("onTouchAddingMemo")
    }
}

extension MemoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as! MemoListCell
        
        cell.selectionStyle = .none
        cell.titleLabel.text = data[indexPath.section][indexPath.row].title
        
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
        print("출발 section 명 : \(sourceIndexPath.section) ㅣ index명 : \(sourceIndexPath.row) -> 도착 section 명 : \(destinationIndexPath.section) ㅣ index명 :  \(destinationIndexPath.row)")
        let moveCell = self.data[sourceIndexPath.section][sourceIndexPath.row]
        self.data[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        self.data[destinationIndexPath.section].insert(moveCell, at: destinationIndexPath.row)
    }
    
    //MARK: - 헤더 관리
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrTitleList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MemoListHeaderView") as! MemoListHeaderView
        
        headerView.contentView.backgroundColor = .white
        
        switch section {
        case 0 :
            headerView.titleLabel.text = arrTitleList[section]
            break
        case 1 :
            headerView.titleLabel.text = arrTitleList[section]
            break
        case 2:
            headerView.titleLabel.text = arrTitleList[section]
            break
        default :
            headerView.titleLabel.text = "기타"
        }
        
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
