//
//  LoginStatusLoad.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 23/1/24.
//

import Foundation

enum LoginStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case errorNetwork(_ error: String)
}