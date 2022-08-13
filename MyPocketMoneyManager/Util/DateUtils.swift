//
//  DateUtils.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/10.
//

import Foundation

class DateUtils {
    
    public func getFirstDate() -> Date {
        let comps = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: Date())
        return Calendar(identifier: .gregorian).date(from: comps)!
    }
    
    public func getNextFirstDate() -> Date {
        let add = DateComponents(month: 1, day: 0)
        return Calendar(identifier: .gregorian).date(byAdding: add, to: getFirstDate())!
    }
    
    public func getLastDate() -> Date {
        let add = DateComponents(month: 1, day: -1)
        return Calendar(identifier: .gregorian).date(byAdding: add, to: getFirstDate())!
    }
    
    public func getRemainDays() -> Int {
        let todayDay = getDay(date: Date())
        let lastDay = getDay(date: getLastDate())
        return lastDay - todayDay
    }
    
    public func getYear(date: Date) -> Int {
        return Calendar.current.component(.year, from: date)
    }
    
    public func getMonth(date: Date) -> Int {
        return Calendar.current.component(.month, from: date)
    }
    
    public func getDay(date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
    
}
