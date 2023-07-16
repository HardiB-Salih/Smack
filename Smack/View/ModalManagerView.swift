//
//  ModalManagerView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import SwiftUI

struct ModalManagerView: View {
    @EnvironmentObject var modalManager: ModalManager

    var body: some View {
        
        ZStack {
            if modalManager.activeModal != .addChannel && modalManager.activeModal != .profile {
                Color.white.ignoresSafeArea()
            } else {
                Color.clear.ignoresSafeArea()
            }
            switch modalManager.activeModal {
            case .signIn :
                LoginView()
            case .signUp:
                CreateAccountView()
                    .transition(.move(edge: .trailing))
            case .profile:
                ProfileModal()
            case .addChannel :
                AddChannelModal()
            }
        
        }
    }
}

struct ModalManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ModalManagerView()
            .environmentObject(ModalManager())
    }
}
