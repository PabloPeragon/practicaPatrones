//
//  LoginViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 23/1/24.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    private var viewModel: LoginViewModel
    
    //MARK: - Inits
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        
    }
    //MARK: - IBAction
    @IBAction func onLoginButtonTap(_ sender: Any) {
        viewModel.onLoginButton(email: emailTextField.text, password: passwordTextField.text)
    }
}

// MARK: - EXTENSION
extension LoginViewController {
    // Metodo para "escuchar" variable de estado del viewModel
    private func setObservers() {
        viewModel.loginViewState = { [weak self] status in
            switch status {
                
            case .loading(let isloading):
                self?.loadingView.isHidden = !isloading
                
            case .loaded:
                self?.loadingView.isHidden = true
                self?.navigateToHome()
                
            case .showErrorEmail(let error):
                self?.errorEmail.text = error
                self?.errorEmail.isHidden = (error == nil || error?.isEmpty == true)
                
            case .showErrorPassword(let error):
                self?.errorPassword.text = error
                self?.errorPassword.isHidden = (error == nil || error?.isEmpty == true)
                
            case .errorNetwork(let errorMessage):
                self?.loadingView.isHidden = true
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    //MARK: - Navigate
    private func navigateToHome() {
        let nextVC = HomeTableViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
    //MARK: - Alert
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "ERROR NETWORK", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
