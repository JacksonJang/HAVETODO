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
import JangNetwork

struct MemoList: Codable {
    var idx:Int
    var data:[String:[Memo]]
    
    enum CodingKeys: String, CodingKey {
        case idx = "idx"
        case data = "data"
    }
}

struct Memo: Codable {
    var title:String
    var content:String
    var priority:Int
    var createDate:String
    var updateDate:String
}

class MemoListVC: BaseViewController, Storyboarded {
    static var storyboardName: String = String(describing: MemoListVC.self)
    
    @IBOutlet var tableView: UITableView!
    
    var data: [[Memo]] = []
    var sectionTitleList:[String] = [] //타이틀 리스트 (매일반복, 오늘, 기한이 지난 일)
    
    var headerView:MemoListHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupTitleData()
        parseJSONDataToModel()
    }
    
    func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.register(UINib(nibName: "MemoListCell", bundle: nil), forCellReuseIdentifier: "MemoListCell")
        tableView.register(UINib(nibName: "MemoListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MemoListHeaderView")
    }
    
    func setupTitleData() {
        sectionTitleList.removeAll()
        
        let year = getTodayYear()
        let month = getTodayMonth()
        let day = getTodayDay()
        
        //형식 : 오늘 (2021년 12월 10일 금요일)
        let sectionTitleForToday = "오늘 (\(year)년 \(month)월 \(day)일 \(getWeekDay(atYear: Int(year)!, atMonth: Int(month)!, atDay: Int(day)!))요일)"
        
        sectionTitleList.append("매일 반복")
        sectionTitleList.append(sectionTitleForToday)
        sectionTitleList.append("기한이 지난 일")
    }
    
    func parseJSONDataToModel() {
        JN.request(url: "https://gist.githubusercontent.com/JacksonJang/471f451c9905fb7f79e934079234b2ba/raw/8ef48a61e1d8ab7164b0c734bb30be16d8383327/Memo.json"){ result in
            
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let memoList = try? decoder.decode(MemoList.self, from: data)
                
                    if let data = memoList!.data["everyday"] {
                        self.data.append(data)
                    }
                    
                    if let data = memoList!.data["today"] {
                        self.data.append(data)
                    }
                    
                    if let data = memoList!.data["tomorrow"] {
                        self.data.append(data)
                    }
                    
                    self.tableView.reloadData()
                    break
                case .failure(let error):
                break
                    // do somthing with the result in failure
            }
            
        }
        
    }
    
    @IBAction func onTouchAddingMemo(_ sender: Any) {
        print("onTouchAddingMemo")
    }
}

extension MemoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: everyday, today, tomorrow 중 누락된게 있으면 개수 에러남. 에러 해결 필요
        if data.count == 0 {
            return 0
        }
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
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MemoListHeaderView") as! MemoListHeaderView
        
        headerView.contentView.backgroundColor = .white
        
        switch section {
        case 0 :
            headerView.titleLabel.text = sectionTitleList[section]
            break
        case 1 :
            headerView.titleLabel.text = sectionTitleList[section]
            break
        case 2:
            headerView.titleLabel.text = sectionTitleList[section]
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
