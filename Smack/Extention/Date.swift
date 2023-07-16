//
//  Date.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import Foundation
import Firebase

extension Timestamp {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self.dateValue())
    }
}
