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
