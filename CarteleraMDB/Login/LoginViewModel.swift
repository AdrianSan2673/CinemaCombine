//
//  LoginViewModel.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import Combine
import FirebaseAuthCombineSwift
import Firebase
import FirebaseAuth

class LoginViewModel {
    @Published var email = ""
    @Published var password = ""
    @Published var isEnable = false
    @Published var showLoading = false
    @Published var errorMessage = ""
    @Published var userModel: Userq?
    
    var cancellables = Set<AnyCancellable>()
    
    let apiClient: ApiClient
  
    init(apiClient: ApiClient){
        self.apiClient = apiClient
        self.formValidation()
    }
    
    func formValidation(){
        Publishers.CombineLatest($email, $password)
            .filter { email, password in
                return email.count > 5 && password.count > 5
            }
            .sink { value in
                self.isEnable = true
            }.store(in: &cancellables)
    }
    
    @MainActor
    func userLogin(withEmail email: String, password: String) {
        errorMessage = ""
        showLoading = true
        apiClient.login(withEmail: email, password: password) { (result: Userq?, error: BackendError?) in
            if let data = result {
                self.userModel = data
            } else if let loginError = error {
                self.errorMessage = loginError.rawValue
            }
            self.showLoading = false
        }
    }
}
