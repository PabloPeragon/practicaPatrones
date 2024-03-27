//
//  HomeUseCase.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 26/1/24.
//

import Foundation

//MARK: - PROTOCOLO HOME USE CASE
protocol HomeUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void)
}

//MARK: - Clase HomeUseCase que conforma el protocolo de arriba
final class HomeUseCase: HomeUseCaseProtocol  {
    
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.heroesList.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        //Crear token
        guard let token = UserDefaultsHelper.getToken() else {
            onError(.tokenFormatError)
            return
        }
        
        //Crear REQUEST
        //TODO: - Obtener el token de algun lado
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        
        //Body
        struct HeroRequest: Encodable {
            let name: String
        }
        
        let heroRequest = HeroRequest(name: "")
        urlRequest.httpBody = try? JSONEncoder().encode(heroRequest)
        
        //TASK
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //Chesck Error
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
final class HomeUseCaseFakeSuccess: HomeUseCaseProtocol {
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
final class HomeUseCaseFakeError: HomeUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            onError(.noData)
        }
    }
}
