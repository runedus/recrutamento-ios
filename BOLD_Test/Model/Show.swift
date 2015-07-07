//
//  Show.swift
//  BOLD_Test
//
//  Created by Rodrigo Cai on 7/7/15.
//  Copyright (c) 2015 Rodrigo Cai. All rights reserved.
//

import Foundation

class Show : NSObject {
    var title : String
    var year : Int
    var images : Dictionary<String, AnyObject>
    
    init(title: String, year: Int, images: Dictionary<String, AnyObject>) {
        self.title = title
        self.year = year
        self.images = images
    }
    
    func posterThumbURL() -> String {
        let poster = self.images["poster"] as! Dictionary<String, String>
        return poster["thumb"]!
    }
}