//
//  ModalManager.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import Foundation

class ModalManager: ObservableObject {
    enum ActiveModals {
        case signIn
        case signUp
        case profile
        case addChannel
    }
    
    @Published public var showModal: Bool = false
    @Published public var activeModal: ActiveModals = .signIn
}
