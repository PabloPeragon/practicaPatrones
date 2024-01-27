//
//  characterTableViewCell.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 27/1/24.
//

import UIKit

class characterTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    //MARK: - Configure
    func configure(with character: HeroModel ) {
        characterName.text = character.name
        
        guard let imageURL = URL(string: character.photo) else {
            return
        }
        characterImageView.setImage(url: imageURL)
    }
    
}
