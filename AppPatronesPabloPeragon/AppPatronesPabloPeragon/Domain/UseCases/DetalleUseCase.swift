//
//  DetalleUseCase.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 28/1/24.
//

import Foundation
//MARK: - PROTOCOLO Detalle de Uso
protocol DetalleUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void)
}

//MARK: - Clase DetalleUseCase que conforma el protocolo de arriba
final class DetalleUseCase: DetalleUseCaseProtocol  {
    
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.allHeros.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        //Crear token
        guard let token = UserDefaulsHelper.getToken() else {
            onError(.tokenFormatError)
            return
        }
        
        //Crear REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-Type")
        
        //Body
        struct HeroRequest: Encodable {
            let name: String
        }
        
        let heroRequest = HeroRequest(name: "")
        urlRequest.httpBody = try? JSONEncoder().encode(heroRequest)
        
        //TASK
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //Check Error
            guard error == nil else {
                onError(.other)
                return
            }
            
            //Check Data
            guard let data = data else {
                onError(.noData)
                return
            }
            
            //Check response
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroResponse = try? JSONDecoder().decode([HeroModel].self, from: data) else {
                onError(.decoding)
                return
            }
            
            onSuccess(heroResponse)
        }
        task.resume()
    }
}

//MARK: - Fake Success
final class DetalleUseCaseFakeSuccess: DetalleUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let heroes = [HeroModel(id: "1", name: "Diego", description: "Superman", photo: "", favorite: true),
            HeroModel(id: "2", name: "Alejandro", description: "Spiderman", photo: "", favorite: false),
            HeroModel(id: "3", name: "Rocio", description: "Super Woman", photo: "", favorite: true)]
            
            onSuccess(heroes)
        }
    }
}

//MARK: - Fake Error
final class DetalleUseCaseFakeError: DetalleUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            onError(.noData)
        }
    }
}
