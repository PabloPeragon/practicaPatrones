//
//  SplashViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 23/1/24.
//

import UIKit

final class SplashViewController: UIViewController {

    // MARK: - Iboutles
    @IBOutlet weak var splashActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel: SplashViewModel
    
    // MARK: Inits
    init(viewModel: SplashViewModel = SplashViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        viewModel.simulationLoadData()

    }
    
    private func setObservers() {
        viewModel.modelStatusLoad = { [weak self] status in
            switch status {
            case .loading:
                self?.showLoading(show: true)
            case .loaded:
                self?.showLoading(show: false)
                self?.navigateToLogin()
            case .error:
                print("Error Splash")
                
            case .none:
                print("None Splash")
            }
        }
    }
    
    
    private func showLoading(show: Bool) {
        switch show {
        case true where !splashActivityIndicator.isAnimating:
            splashActivityIndicator.startAnimating()
        case false where splashActivityIndicator.isAnimating:
            splashActivityIndicator.stopAnimating()
        default : break
        }
    }
    

    
    private func navigateToLogin() {
        let nextVM = LoginViewModel(useCase: LoginUseCase())
        let nextVC = LoginViewController(viewModel: nextVM)
        navigationController?.setViewControllers([nextVC], animated: false)
    }
}

