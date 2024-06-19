//
//  ApiClient.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import FirebaseAuth
import Firebase
import CoreMedia

enum BackendError: String,Error {
    case invalidEmail = "Comprueba el Email"
    case invalidPassword = "Comprueba tu password"
}

final class ApiClient {
    
    func login(withEmail email: String, password: String, completion: @escaping(Userq?,BackendError?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, BackendError.invalidEmail)
            } else {
                let userq = authResult?.user
                let userCompletion = Userq(name: userq?.email ?? "user1", password: password, isAuthentication: true, sessionStar: .now)
                completion(userCompletion, nil)
            }
        }
    }
}
