//
//  HeroDetalleModel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 27/1/24.
//

import Foundation

final class DetailViewModel {
    
    //heroe recibido
    var dataHeroe: HeroModel = HeroModel(id: "", name: "", description: "", photo: "", favorite: true)
    
    
    //binding con UI
    var detailStatusLoad: ((SplashStatusLoad) -> Void)?
    
    //caseUse
    let caseUse: DetailUseCaseProtocol
    let name: String
    
    //init
    init(caseUse: DetailUseCaseProtocol = DetailUseCase(), name: String = "Goku") {
        self.caseUse = caseUse
        self.name = name
    }
    
    //Llamada a detale de Heroe
    
    func loadHero() {
        caseUse.getHero(name: name) { [weak self] hero in
            DispatchQueue.main.async {
                self?.dataHeroe = hero.first!
                self?.detailStatusLoad?(.loaded)
            }
        } onError: { [weak self] error in
            DispatchQueue.main.async {
                self?.detailStatusLoad?(.error)
            }
        }
    }
}
