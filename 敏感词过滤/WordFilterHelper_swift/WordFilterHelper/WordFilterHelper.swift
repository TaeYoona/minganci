//
//  WordFilterHelper.swift
//  WordFilterHelper
//
//  Created by zhangcong on 2017/10/13.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

import Foundation

let EXIST = "isExists"

class WordFilterHelper: NSObject {
    
    static let shareInstance = WordFilterHelper();
    
    var root : NSMutableDictionary = NSMutableDictionary.init()
    var isFilterClose : Bool = false
    
    override init() {
        super.init()
        initFilter()
    }
    
    func initFilter() {
        let filepath = Bundle.main.path(forResource: "minganci", ofType: "txt")
        var dataFile:NSString?=nil
        do{
            dataFile=try NSString(contentsOfFile: filepath!,encoding: String.Encoding.utf8.rawValue)
            let dataarr=dataFile?.components(separatedBy: "\n")
            for item in dataarr! {
                if item.characters.count > 0 {
                    insertWords(words: item as NSString)
                }
            }
        }catch{
            
        }
        
    }
    
    func insertWords(words:NSString) {
        var node : NSMutableDictionary = root
        for i in stride(from: 0, to: words.length, by: 1) {
            
            let word = words.substring(with: NSRange(location: i, length: 1))
            if node.object(forKey: word) == nil
            {
                let dict = NSMutableDictionary.init()
                node.setObject(dict, forKey: word as NSCopying)
            }
           
            node = node.object(forKey: word) as! NSMutableDictionary
        }
        node .setObject(NSNumber.init(integerLiteral: 1), forKey: EXIST as NSCopying)
    }
    
    func filter(str:NSString) -> NSString {
        if isFilterClose || self.root.count == 0 {
            return str
        }
        
        let result : NSMutableString = str.mutableCopy() as! NSMutableString
        
        for var i in stride(from: 0, to: str.length, by: 1) {
            let subString : NSString = str.substring(from: i) as NSString
            var node : NSMutableDictionary = root.mutableCopy() as! NSMutableDictionary
            var num = 0
            
            for j in stride(from: 0, to: subString.length, by: 1) {
                let word = subString.substring(with: NSRange(location:j,length:1))
                
                if node.object(forKey: word) == nil {break}
                else {
                    num = num + 1
                    node = node.object(forKey: word) as! NSMutableDictionary
                }
                
                if node.object(forKey: EXIST) != nil {
                    let nodeObj : NSNumber = (node.object(forKey: EXIST) as? NSNumber)!
                    if nodeObj.intValue == 1 {
                        let symbolStr : NSMutableString = NSMutableString.init()
                        
                        for k in stride(from: 0, to: num, by: 1) {
                            print(k)
                            symbolStr.append("*")
                        }
                        
                        result.replaceCharacters(in: NSRange(location:i,length:num), with: symbolStr as String)
                        
                        i = i + j
                        break
                    }

                }
                
            }
        }
        
        return result
    }
    
    func freeFilter() {
        root.removeAllObjects()
    }

    func stopFilter(b:Bool) {
        isFilterClose = b
    }
}


