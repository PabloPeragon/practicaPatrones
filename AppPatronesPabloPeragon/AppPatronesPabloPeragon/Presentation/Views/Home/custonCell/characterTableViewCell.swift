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
    
    func updateViews(hero: HeroModel) {
        update(image: hero.photo)
        update(title: hero.name)
    }
    
    private func update(image: String?) {
        guard let image = image else { return }
        let url = URL(string: image)
        guard let url = url else { return }
        characterImageView.setImage(url: url)
    }
    
    private func update(title: String?) {
        characterName.text = title
    }
}
