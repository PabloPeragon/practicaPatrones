//
//  UserDefaulsHelper.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 26/1/24.
//

import Foundation

class UserDefaultsHelper {
    private static let userDefaults = UserDefaults.standard
    
    private enum Constant {
        static let tokenkey = "KCToken"
    }
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenkey)
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: Constant.tokenkey)
    }
    
    static func deleteToken () {
        userDefaults.removeObject(forKey: Constant.tokenkey)
    }
}
