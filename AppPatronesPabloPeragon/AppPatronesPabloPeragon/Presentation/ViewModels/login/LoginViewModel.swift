//
//  LoginViewModel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 23/1/24.
//

import Foundation

final class LoginViewModel {
    
    //MARK: - binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
    private let useCase: LoginUseCaseProtocol
    
    //MARK: - Init
    init(useCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.useCase = useCase
        
    }
    
    //MARK: - metodo Login
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        //Check email
        guard let email = email, isValid(email: email) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorEmail("Error en el email"))
            return
        }
        
        //Check password
        guard let password = password, isValid(password: password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorPassword("Error en el password"))
            return
        }
        
        doLoginWith(email: email, password: password)
    }
    
    //Check email y password
    private func isValid(email: String) -> Bool {
        email.isEmpty == false && email.contains("@")
        
    }
    
    //Check Password
    private func isValid(password: String) -> Bool {
        password.isEmpty == false && password.count >= 4
    }
    
    private func doLoginWith(email: String, password: String) {
       useCase.login(user: email, password: password) { [weak self] token in
            DispatchQueue.main.async {
                self?.loginViewState?(.loaded)
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                switch(error) {
                case .malformedURL:
                    print("Mal formed URL")
                case .dataFormatting:
                    print("Data Formatting")
                case .other:
                    print("Other")
                case .noData:
                    print("No Data")
                case .errorCode(let error):
                    print("Error Code \(String(describing: error?.description))")
                case .tokenFormatError:
                    print("Token Format Error")
                case .decoding:
                    print("Decoding")
                }
            }
        }
    }
}
