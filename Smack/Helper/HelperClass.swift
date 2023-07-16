//
//  HelperClass.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import Foundation

let helperClass = _HelperClass()
class _HelperClass {
    
    func returnHexColor(components: String) -> String {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultHexColor = "#808080"
        
        guard let rUnwrapped = r else { return defaultHexColor }
        guard let gUnwrapped = g else { return defaultHexColor }
        guard let bUnwrapped = b else { return defaultHexColor }
        guard let aUnwrapped = a else { return defaultHexColor }
        
        let rInt = Int(rUnwrapped.doubleValue * 255)
        let gInt = Int(gUnwrapped.doubleValue * 255)
        let bInt = Int(bUnwrapped.doubleValue * 255)
        
        let hexColor = String(format: "#%02X%02X%02X", rInt, gInt, bInt)
        return hexColor
    }
    
//    func randomHexColor() -> String {
//        let r = CGFloat.random(in: 0...1)
//        let g = CGFloat.random(in: 0...1)
//        let b = CGFloat.random(in: 0...1)
//
//        let rInt = Int(r * 255)
//        let gInt = Int(g * 255)
//        let bInt = Int(b * 255)
//
//        let hexColor = String(format: "#%02X%02X%02X", rInt, gInt, bInt)
//        return hexColor
//    }
    
    func randomHexColor(isLight: Bool) -> String {
        let minValue: CGFloat = isLight ? 0.6 : 0.2
        let maxValue: CGFloat = isLight ? 1.0 : 0.8
        
        let r = CGFloat.random(in: minValue...maxValue)
        let g = CGFloat.random(in: minValue...maxValue)
        let b = CGFloat.random(in: minValue...maxValue)
        
        let rInt = Int(r * 255)
        let gInt = Int(g * 255)
        let bInt = Int(b * 255)
        
        let hexColor = String(format: "#%02X%02X%02X", rInt, gInt, bInt)
        return hexColor
    }

}
