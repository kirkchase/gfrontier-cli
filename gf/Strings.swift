import Foundation

public func condenseWhitespace(string: String) -> String {
    var working = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let components = working.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({ !$0.isEmpty })
    working = components.joinWithSeparator(" ")
    return working
}

public func parseJsonData(data:String) -> NSDictionary?  {
    do {
        let jsonDict = try NSJSONSerialization.JSONObjectWithData(data.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        return jsonDict
    } catch {}
    return nil
}

func jsonData(key:String, _ value:String, _ addComma:Bool = true) -> String {
    if value.length == 0 {
        return ""
    }
    return "\"" + key + "\":\"" + value + "\"" + (addComma ? "," : "")
}

func jsonData(key:String, _ value:Int, _ addComma:Bool = true) -> String {
    return "\"" + key + "\":" + String(value) + (addComma ? "," : "")
}

extension String {
    var length : Int {
        return self.characters.count
    }
}