//
//  AddChannelModal.swift
//  Smack
//
//  Created by HardiB.Salih on 7/15/23.
//

import SwiftUI

struct AddChannelModal: View {
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var messageViewModel : MessageViewModel

    @State var channelName = ""
    @State var channelDescription = ""

    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    withAnimation{
                        modalManager.showModal.toggle()
                    }
                }
                .ignoresSafeArea()
            
            
            VStack {
                VStack (alignment: .center, spacing: 30){
                    Text("Create Channel")
                        .font(.title).fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(AssetsColor.firstColor.rawValue))
                    
                    VStack {
                        TextField("Channel Name", text: $channelName)
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .fill(Color(AssetsColor.firstColor.rawValue).opacity(0.6))
                            .frame(height: 2)
                    }
                    
                    VStack {
                        TextField("Channel Description", text: $channelDescription)
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .fill(Color(AssetsColor.firstColor.rawValue).opacity(0.6))
                            .frame(height: 2)
                    }
                    
                    Button {
                        messageViewModel.createChannel(channelTitle: channelName, channelDescription: channelDescription) { success, error in
                            if success {
                                // handle going back
                                withAnimation {
                                    modalManager.showModal.toggle()
                                }
                            } else {
                                print("User creation in Firestore failed with error: \(error?.localizedDescription ?? "")")

                            }
                        }
                        
                        
                        
                        
                    } label: {
                        Text("Create Channel")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(Color(AssetsColor.secondColor.rawValue))
                            )
                    }

                }
                .padding(40)
                .background(.white)
                .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(content: {
                    Button{
                        withAnimation {
                            modalManager.showModal.toggle()
                        }
                    } label: {
                        Image(AssetsIcon.closeButton.rawValue)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        
                })
            .padding(20)
            .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

struct AddChannelModal_Previews: PreviewProvider {
    static var previews: some View {
        AddChannelModal()
            .environmentObject(ModalManager())
            .environmentObject(MessageViewModel())
    }
}
