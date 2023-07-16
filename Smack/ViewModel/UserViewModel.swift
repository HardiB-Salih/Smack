//
//  UserViewModel.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import FirebaseFirestore
import FirebaseAuth
import Combine

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
                // Sign-in successful, fetch user info
                self.fetchCurrentUser()
            }
        }
    }

    func createUser(email: String, password: String, completion: @escaping (Bool, String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, nil, error)
            } else if let authResult = authResult {
                let uid = authResult.user.uid
                completion(true, uid, nil)
                
                // Sign-in successful, fetch user info
                self.fetchCurrentUser()
            }
        }
    }
    
    func createUserInFirestore(user: User, completion: @escaping (Bool, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
                "id": user.id,
                "avatarColor": user.avatarColor,
                "avatarName": user.avatarName,
                "email": user.email,
                "name": user.name,
                "timeStamp": FieldValue.serverTimestamp()
            ]
        
        db.collection("users").document(user.id).setData(userData) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
        } catch {
            print("Sign-out error: \(error.localizedDescription)")
        }
    }
    
    private func fetchCurrentUser() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No user is currently signed in
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(currentUserUID).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle the error
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                // User document exists
                if let data = snapshot.data() {
                    self.currentUser = User(
                        id: currentUserUID,
                        avatarColor: data["avatarColor"] as? String ?? "",
                        avatarName: data["avatarName"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        name: data["name"] as? String ?? ""
                    )
                }
            } else {
                // User document does not exist
                print("User document does not exist")
            }
        }
    }
    
    func listenForCurrentUserChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            if user != nil {
                // User is signed in
                self.fetchCurrentUser()
            } else {
                // No user is signed in
                self.currentUser = nil
            }
        }
    }
}

