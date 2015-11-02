import Foundation

public let mainMenuMap: [(key:String, value:String)] = [
    ("cards", "Cards - View cards"),
    ("quit", "Quit")
]


public func getMenuAction(title:String, actionMap:[(key:String, value:String)], prompt:String = "Option #: ") -> String {
    print("\n\(title)")
    var count = 1
    for (_, value) in actionMap {
        print(" \(count). \(value)")
        count++
    }
    print("")
    return getMenuAction(prompt, actionMap)
}

public func pause(prompt:String = ">>>", blanks:Bool = false) {
    if blanks {
        print("\n")
    }
    print(prompt, terminator:"")
    if blanks {
        print("\n")
    }
}

private func getMenuAction(prompt:String, _ menus:[(key:String, value:String)]) -> String {
    var action = "";
    repeat {
        print(prompt, terminator:"")
         //stdin.read()
        if let item:String = readLine() {
            action = item.lowercaseString
            
            if let command = isAction(action, menus) {
                return command
            }
        }
    } while true
}

private func isAction(search:String, _ menus:[(key:String, value:String)]) -> String? {
    for i in 0..<menus.count {
        let action = menus[i]

        if search == String(i + 1) {
            return action.key
        } else if search == action.key.lowercaseString {
            return action.key
        }
    }
    
    return nil
}

