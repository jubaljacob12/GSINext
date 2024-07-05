//
//  AuthViewModel.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//

import Foundation
import FirebaseAuth


class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Signed in succesfully")
            print("DEBUG: User id \(result?.user.uid)")
            self.userSession = result?.user
        }
    }
    
    func registerUser(withEmail email: String, password: String,fullname: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Registered user succesfully")
            print("DEBUG: User id \(result?.user.uid)")
            self.userSession = result?.user
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            print("DEBUG: Did sign out with firebase...")
        }catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
