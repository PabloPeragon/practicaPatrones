//
//  extension+UIImageView.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 27/3/24.
//

import UIKit

extension UIImageView {
    
    func setImage(url: URL) {
        downloadImageWithURLSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    
    //Metodo para descagr imagen desde URLSession
    private func downloadImageWithURLSession(url: URL, completion: @escaping (UIImage?)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else
            {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else
            {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

