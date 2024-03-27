//
//  DetalleUseCase.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 28/1/24.
//

import Foundation

protocol DetailUseCaseProtocol {
    func getHero (name: String, success: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError?) -> Void)
}

final class DetailUseCase: DetailUseCaseProtocol {
    func getHero (name: String, success: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError?) -> Void) {
        
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.heroesList.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        //Checkear el token
        guard let token = UserDefaultsHelper.getToken() else {
            onError(.other)
            return
        }
        
        //Crear Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        
        //necesitamos pasarle un body
        struct HeroRequest: Encodable {
            let name: String
        }
        let heroRequest = HeroRequest(name: name)
        
        //le agregamos ese body a mi urlRequest
        urlRequest.httpBody = try? JSONEncoder().encode(heroRequest)
        
        //Crear DATATASK
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            //check error
            guard error == nil else {
                onError(NetworkError.other)
                return
            }
            
            //Miramos que la data tenga contenido
            guard let data = data else {
                onError(NetworkError.noData)
                return
            }
            
            //Miramos respuesta recibida
            guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            //Transformar el resultado
            guard let heroesResponse = try? JSONDecoder().decode([HeroModel].self, from: data) else {
                onError(.decoding)
                return
            }
            
            print(heroesResponse)
            success(heroesResponse)
            
        }
        task.resume()
        
    }
}

