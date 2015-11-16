import Foundation

public func doMenuSelection(title:String,
    menuItems:[(title:String, payload:Any?, action: (_:Any?) -> String?)],
    prompt:String = "Option #: ") -> Int {
        print("\n\(title)")
        var count = 1
        for (title, _, _) in menuItems {
            print(" \(count). \(title)")
            count++
        }
        print("")
        return getSelectedIndex(prompt, menuItems.count)
}

private func getSelectedIndex(prompt:String, _ count:Int) -> Int {
    repeat {
        print(prompt, terminator:"")
        
        let index = stdin.read() as Int?
        
        
        if let index = index {
            if index > 0 && index <= count {
                return index - 1;
            }
        } else {
            print("** Invalid Input ** Enter a number between 1-\(count)")
        }
    } while true
}


public func pauseit() {
    print("< Press Return to continue > ", terminator:"")
    let _ = stdin.read() as String?
}
