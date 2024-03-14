//
//  SplashViewModel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 23/1/24.
//

import Foundation

final class SplashViewModel {
    // binding con UI
    var modelStatusLoad: ((SplashStatusLoad) -> Void)?
    
    // Funcion simular carga datos
    func simulationLoadData(){
        //Variable estado --> ESTOY CARGANDO
        modelStatusLoad?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {  [weak self] in
            //Variable estado --> YA ME CARGADO
            self?.modelStatusLoad?(.loaded)
        }
    }
}
