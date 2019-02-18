//
//  FIleToDownloadData.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class FIleToDownloadData: NSObject {

    func downloadChat(completionBlock:@escaping (_ result:NSMutableArray)->Void)  {
        let strUrl = "https://dcoder.tech/test_json/chat.json";
        self.getDataFromURL(strUrl: strUrl) { (arrayData) in
            let chats = Chats()
            completionBlock(chats.parseData(objArray: arrayData));
        }
    }
    
    func downloadCodes(completionBlock:@escaping (_ result:NSMutableArray)->Void)  {
        let strUrl = "https://dcoder.tech/test_json/codes.json";
        self.getDataFromURL(strUrl: strUrl) { (arrayData) in
            let codes = Codes()
            completionBlock(codes.parseData(objArray: arrayData));
        }
    }
    
    func getDataFromURL(strUrl:String,completionBlock:@escaping (_ result:NSArray)->Void) {
        let url = URL.init(string: strUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse, options: [])
                print(jsonResponse as! NSArray)
                completionBlock(jsonResponse as! NSArray);
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
}
