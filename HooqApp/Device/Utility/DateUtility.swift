//
//  DateUtility.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

struct DateUtility {
    
    static let dateFormat = "yyyy-MM-dd"
    
    static func year(from dateString: String?) -> Int {
        
        guard let dateString = dateString else {
            return 0
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: dateString) else { return 0 }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return year
    }
    
}
