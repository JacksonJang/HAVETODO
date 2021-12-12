//
//  Week.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/12/12.
//

import UIKit

func checkLeap(year: Int) -> Bool {
    var checkValue: Bool = false
    if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0){
        checkValue = true
    }else {
        checkValue = false
    }
    return checkValue
}

func endDayOfMonth(year: Int, month: Int) -> Int {
    
    var endDay: Int = 0
    let inputMonth: Int = month
    
    let monA: Set = [1,3,5,7,8,10,12]
    let monB: Set = [4,6,9,11]
    
    if monA.contains(inputMonth)  {
        endDay = 31
    }else if monB.contains(inputMonth) {
        endDay = 30
    }
    
    if inputMonth == 2 {
        if checkLeap(year: year) {
            endDay = 29
        }else {
            endDay = 28
        }
    }
    return endDay
}

//요일 구하기
func getWeekDay(atYear:Int, atMonth:Int, atDay:Int) -> String {
    
    var dayDay:[String] = ["금", "토", "일", "월", "화", "수", "목"]
    var returnValue: String = ""
    var totalDay: Int = 0
    
    for i in 1..<atMonth {
        totalDay += endDayOfMonth(year: atYear, month: i)
    }
    
    var index: Int = 0
    if (totalDay + atDay) % 7 == 0 {
        index = 6
    }else {
        index = (totalDay + atDay) % 7 - 1
    }
    
    returnValue = dayDay[index]
    
    return returnValue
}

