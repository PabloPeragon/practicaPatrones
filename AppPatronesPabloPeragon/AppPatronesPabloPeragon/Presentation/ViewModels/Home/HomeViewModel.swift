//
//  HomeViewModel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 26/1/24.
//

import Foundation

final class HomeViewModel {
    
    //binding con UI(para conectarse con la vista)
    var homeStatusLoad: ((SplashStatusLoad) -> Void)?
    
    //caseUse(para conectarser con el caso de uso)
    let homeUseCase: HomeUseCaseProtocol
    
    var dataHeroes: [HeroModel] = Array<HeroModel>()
    
    //init que necesita el caso de uso
    init(homeUseCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.homeUseCase = homeUseCase
    }
    
    //Llamada a getHeroes
    func loadHeros() {
        homeStatusLoad?(.loading)
        
        homeUseCase.getHeroes { [weak self] heroes in
            DispatchQueue.main.async {
                self?.dataHeroes = heroes
                self?.homeStatusLoad?(.loaded)
            }
        } onError: { [weak self] error in
            DispatchQueue.main.async {
                self?.homeStatusLoad?(.error)
                
            }

        }

    }
}
