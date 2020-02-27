//
//  Utils.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 27/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import Foundation

var dateFormats = [
    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    "yyyy-MM-dd'T'HH:mm:ss'Z'",
    "yyyy-MM-dd'T'HH:mm:ss'+00:00'"
]

func getReadableDate(_ s: String?) -> String? {
    guard let dateString = s else {
        return ""
    }

    let dateFormatterOutput = DateFormatter()
    dateFormatterOutput.dateFormat = "yyyy-MM-dd HH:mm"
    
    let dateFormatter = DateFormatter()

    var date : Date?
    
    for format in dateFormats {
        dateFormatter.dateFormat = format
        date = dateFormatter.date(from: dateString)
        if date != nil {
            break
        }
    }
    
    guard let dateToFormat = date else {
        return s
    }
    
    return dateFormatterOutput.string(from: dateToFormat)
}
