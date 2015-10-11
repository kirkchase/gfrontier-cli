//
//  FileUtils.swift
//  GFCli
//
//  Created by Kirk Chase on 10/9/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public func readFromDocumentsFile(fileName:String) -> String? {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    let path = documentsPath.stringByAppendingPathComponent(fileName)
    let checkValidation = NSFileManager.defaultManager()
    //    var error:NSError?
    //    var file:String
    
    if checkValidation.fileExistsAtPath(path) {
        let location = NSString(string:"~/file.txt").stringByExpandingTildeInPath
        let fileContent = try? NSString(contentsOfFile: location, encoding: NSUTF8StringEncoding)
        return fileContent as String?
    }
    return nil
}

public func readJsonFile(filePath:String?) -> String? {
    //    let jsonData = NSData(contentsOfFile:filePath!)
    
    return nil
}

public func readFileInDocumentDirectory(file: String) -> String? {
    if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
        let path = dir.stringByAppendingPathComponent(file);
        
        //writing
        //reading
        do {
            let text = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            
            let returnText = text.stringByReplacingOccurrencesOfString("\n", withString: "")
            return returnText
        }
        catch {/* error handling here */}
    }
    
    return nil
}

public func readFileInPath(filePath: String) -> String? {
    if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
        do {
            //todo check path
            
            let text = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            
            return text as String
        }
        catch {/* error handling here */}
    }
    
    return nil
}




//let filePath = NSBundle.mainBundle().pathForResource("MyJSONFileName",ofType:"json")
//// 2
//var readError:NSError?
//// 3
//let data = NSData(contentsOfFile:filePath!, options:NSDataReadingOptions.DataReadingUncached, error:&readError)
//if let data = NSData(contentsOfFile:filePath!, options:NSDataReadingOptions.DataReadingUncached, error:&readError) {
//    // 4
//    let stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
//    // 5
//    println("data read: \(stringData)")
//}