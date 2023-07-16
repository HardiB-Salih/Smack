//
//  Message.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import Foundation

struct Message : Identifiable {
    public private(set) var id: String
    public private(set) var message: String
    public private(set) var userName: String
    public private(set) var channelId: String
    public private(set) var userAvatar: String
    public private(set) var userAvatarColor: String
    public private(set) var timeStamp: String
}
