//
//  HeroDetalleModel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 27/1/24.
//

import Foundation

final class HeroDetalleModel {
    
    //binding con UI
    var modelStatusLoad: ((SplashStatusLoad) -> Void)?
    
    //caseUse
    let detalleUseCase: DetalleUseCaseProtocol
    
    var dataHeroe: [HeroModel] = []
    //init
    init(detalleUseCase: DetalleUseCaseProtocol = DetalleUseCase()) {
        self.detalleUseCase = detalleUseCase
    }
    
    //Llamada a detale de Heroe
    func loadHeros() {
        modelStatusLoad?(.loading)
        
        detalleUseCase.getHeroes { [weak self] heroes in
            DispatchQueue.main.async {
                print(heroes)
                self?.dataHeroe = heroes
                self?.modelStatusLoad?(.loaded)
            }
        } onError: { [weak self] networkError in
            DispatchQueue.main.async {
                self?.modelStatusLoad?(.error)
   
            }
        }
    }
}




/*

            func loadDetalle() {
                modelStatusLoad?(.loading)
                
                detalleUseCase.getHeroes { [weak self] hero in
                    DispatchQueue.main.async {
                        self?.dataHeroe = hero
                        self?.modelStatusLoad?(.loaded)
                        
                    }
                } onError: { [weak self] networError in
                    DispatchQueue.main.async {
                        self?.modelStatusLoad?(.error)
*/
