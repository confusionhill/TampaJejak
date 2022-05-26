//
//  AuthenticationService.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import UIKit
import Firebase

final class AuthenticationService {
    private var handle: AuthStateDidChangeListenerHandle?
    
    let fireStore = Firestore.firestore()
    var ref: DocumentReference?
    
    public var getUser: User? {
        return Auth.auth().currentUser
    }
    
    public func getUserState(
        completion:@escaping (Result<User, Error>) -> ()
    ) {
        self.handle = Auth.auth().addStateDidChangeListener {auth, user in
            if user == nil {
               // completion(.failure(Error.self as! Error))
            } else {
                completion(.success(user!))
            }
        }
    }
    
    public func stopGetUserState() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    public func loginUser(
        username: String, password: String,
        completion:@escaping (Result<AuthDataResult, Error>) -> ()
    ){
        self.tryToAuth(username: username, password: password, completion: completion)
//        if username.isValidEmail() {
//            self.tryToAuth(username: username, password: password, completion: completion)
//        } else {
//            do {
//                let path = try self.fireStore.document("user-details/\(username)")
//                path.getDocument {[weak self] snapshot, error in
//                    if error != nil {
//                        completion(.failure(error!))
//                    } else {
//                        if let email = snapshot?.data()?["email"] as? String {
//                            self?.tryToAuth(username: email, password: password, completion: completion)
//                        }
//                    }
//                }
//            } catch (let e) {
//                completion(.failure(e))
//            }
//
//        }

    }
    
    
    private func tryToAuth(
        username: String, password:String,
        completion:@escaping (Result<AuthDataResult, Error>) -> ()
    ) {
        Auth.auth().signIn(withEmail: username, password: password) {authResult, error in
            if let authResult = authResult {
                completion(.success(authResult))
            } else {
                print(error?.localizedDescription)
                completion(.failure(error!))
            }
        }
    }
    
    public func registerUser(
        signUpModel: SignUpUserModel,
        completion:@escaping (Result<AuthDataResult, Error>) -> ()
    ){
        Auth.auth().createUser(withEmail: signUpModel.email, password: signUpModel.password) {[weak self] authResult, error in
            guard let self = self else { return }
            if error != nil {
                completion(.failure(error!))
            } else {
                let path = self.fireStore.document("user-details/\(signUpModel.main.userName)")
                path.setData([
                    "email": signUpModel.email,
                    "fullname": signUpModel.main.fullName,
                    "gender": signUpModel.main.gender.rawValue,
                    "phone-number": signUpModel.main.phoneNumber
                ])
                completion(.success(authResult!))
            }
        }
    }
}
