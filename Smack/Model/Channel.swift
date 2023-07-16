//
//  Channel.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import Foundation

struct Channel: Identifiable, Hashable{
    public private(set) var id: String = UUID().uuidString
    public private(set) var channelTitle: String
    public private(set) var channelDescription: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var channels = [
    Channel(channelTitle: "general", channelDescription: ""),
    Channel(channelTitle: "iOS", channelDescription: ""),
    Channel(channelTitle: "Android", channelDescription: ""),
    Channel(channelTitle: "flutter", channelDescription: ""),
    Channel(channelTitle: "react", channelDescription: ""),
]
