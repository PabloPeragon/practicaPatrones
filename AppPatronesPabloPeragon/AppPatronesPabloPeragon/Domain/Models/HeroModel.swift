//
//  Heromodel.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 26/1/24.
//

import Foundation

struct HeroModel: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
}
