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
    
    private let loginUseCase: LoginUseCaseProtocol
    
    //MARK: - Init
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        
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
        loginUseCase.login(user: email, password: password) { [weak self] token in
            DispatchQueue.main.async {
                self?.loginViewState?(.loaded)
            }
            
        } onError: { [weak self] networkError in
            DispatchQueue.main.async {
                var errorMessage = "Error Desconocido"
                switch networkError {
                case .malformedURL:
                    errorMessage = "malformedURL"
                case .dataFormatting:
                    errorMessage = "dataFormatting"
                case .other:
                    errorMessage = "other"
                case .noData:
                    errorMessage = "noData"
                case .errorCode(let error):
                    errorMessage = "ErrorCode \(error?.description ?? "Unknown")"
                case .tokenFormatError:
                    errorMessage = "tokenFormatError"
                case .decoding:
                    errorMessage = "decoding"
                }
                self?.loginViewState?(.errorNetwork(errorMessage))
            }
        }
    }
}
