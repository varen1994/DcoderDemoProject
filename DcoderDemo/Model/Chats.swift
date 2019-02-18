//
//  Chats.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class Chats: NSObject {
    var array = NSMutableArray.init()
    func parseData(objArray:NSArray)->NSMutableArray  {
        for objDic in objArray {
           let chat = Chat();
           chat.putDataInObject(dict: objDic as! NSDictionary)
           array.add(chat) ;
        }
        return array;
    }
}


class Chat:NSObject {
    var user_name:String?
    var user_image_url:String?
    var is_sent_by_me:Bool?
    var text:String?
    
    func putDataInObject(dict:NSDictionary)  {
        if let name =  dict.value(forKey: "user_name") {
            user_name = name as? String;
        }
        
        if let image_name = dict.value(forKey: "user_image_url") {
            user_image_url = replacehttp(strURL:image_name as! String )
        }
        
        if let boolean = dict.value(forKey: "is_sent_by_me")  {
            is_sent_by_me = (boolean as! Bool);
        }
       
        if let textTemp =  dict.value(forKey: "text") {
            text = (textTemp as! String);
        }
    }
    
    func replacehttp(strURL:String)->String {
        var comps = URLComponents(string: strURL)!
        comps.scheme = "https"
        let https = comps.string!
        return https;
    }
    
}
