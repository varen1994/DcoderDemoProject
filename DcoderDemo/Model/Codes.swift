//
//  Codes.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class Codes: NSObject {
    var array = NSMutableArray.init()
    func parseData(objArray:NSArray)->NSMutableArray  {
        for objDic in objArray {
            let code = Code();
            code.putDataInObject(dict: objDic as! NSDictionary)
            array.add(code) ;
        }
        return array;
    }
}


class Code:NSObject {
    var user_name:String?
    var user_image_url:String?
    var time:String?
    var tages:NSArray?
    var title:String?
    var code:String?
    var code_language:String?
    var upvotes:Int?
    var comments:Int?
    var downvotes:Int?
    
    func putDataInObject(dict:NSDictionary)  {
        self.user_name = dict.value(forKey: "user_name") as? String
        if let userImage = dict.value(forKey: "user_image_url") as? String {
            self.user_image_url = self.replacehttp(strURL: userImage);
        }
        self.time = dict.value(forKey: "time") as? String
        self.tages = dict.value(forKey: "tags") as? NSArray
        self.title = dict.value(forKey: "title")as? String
        self.code = dict.value(forKey: "code") as? String
        self.code_language = dict.value(forKey: "code_language") as? String
        self.upvotes = dict.value(forKey: "upvotes") as? Int
        self.downvotes = dict.value(forKey: "downvotes") as? Int
        self.comments = dict.value(forKey: "comments") as? Int
    }
    
    func replacehttp(strURL:String)->String {
        var comps = URLComponents(string: strURL)!
        comps.scheme = "https"
        let https = comps.string!
        return https;
    }
    
}
