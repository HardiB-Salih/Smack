//
//  MessageViewModel.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import FirebaseFirestore
import FirebaseAuth
import Combine

class MessageViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    @Published var messages: [Message] = []
    
    
    // Firestore collection references
    private var channelsCollection: CollectionReference {
        return Firestore.firestore().collection("channels")
    }
    
    private var messagesCollection: CollectionReference {
        return Firestore.firestore().collection("messages")
    }
    
    // Function to create a new channel
    func createChannel(channelTitle: String, channelDescription: String, completion: @escaping (Bool, Error?) -> Void) {
        let newChannel: [String: Any] = [
                "channelTitle": channelTitle,
                "channelDescription": channelDescription,
                "timestamp": FieldValue.serverTimestamp()

            ]
        
        channelsCollection.addDocument(data: newChannel) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // Function to retrieve all channels in ascending order by timestamp (oldest first)
    func retrieveChannels() {
        channelsCollection.order(by: "timestamp", descending: false).addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error retrieving channels: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.channels = snapshot.documents.compactMap { document in
                let data = document.data()
                let id = document.documentID
                let channelTitle = data["channelTitle"] as? String ?? ""
                let channelDescription = data["channelDescription"] as? String ?? ""
                
                return Channel(id: id, channelTitle: channelTitle, channelDescription: channelDescription)
            }
        }
    }



    
    // Function to create a new message
    func createMessage(message: String, userName: String, channelId: String, userAvatar: String, userAvatarColor: String, completion: @escaping (Bool, Error?) -> Void) {
        let newMessage: [String: Any] = [
                "message": message,
                "userName": userName,
                "channelId": channelId,
                "userAvatar": userAvatar,
                "userAvatarColor": userAvatarColor,
                "timestamp": FieldValue.serverTimestamp()
            ]

    
        messagesCollection.addDocument(data: newMessage) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // Function to retrieve messages for a specific channel
    func retrieveMessages(channelId: String) {
        messagesCollection
            .order(by: "timestamp", descending: false)
            .whereField("channelId", isEqualTo: channelId)
            .addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error")
                print("Error retrieving messages: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            self.messages = snapshot.documents.compactMap { document in
                let data = document.data()
                let id = document.documentID
                let message = data["message"] as? String ?? ""
                let userName = data["userName"] as? String ?? ""
                let channelId = data["channelId"] as? String ?? ""
                let userAvatar = data["userAvatar"] as? String ?? ""
                let userAvatarColor = data["userAvatarColor"] as? String ?? ""
                
                print(self.messages.count)
                return Message(id: id, message: message, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: "")
            }
        }
    }
}

