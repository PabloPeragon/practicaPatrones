//
//  DetalleViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 28/1/24.
//

import UIKit

class DetalleViewController: UIViewController {
    
    //IBOoutlet
    
    @IBOutlet weak var ImagenHero: UIImageView!
    @IBOutlet weak var LabelHero: UILabel!
    @IBOutlet weak var DescriptionHero: UITextView!
    
    //VeiwModel
    private var viewModel: HeroDetalleModel
    
    //Init
    init(viewModel: HeroDetalleModel = HeroDetalleModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadDetalle()
        setObservers()


    }
}

extension DetalleViewController {
    
    private func setObservers() {
        func configuration(with hero: HeroModel) {
            LabelHero.text = hero.name
            DescriptionHero.text = hero.description
            guard let imageURL = URL(string: hero.photo) else {
                return
            }
            ImagenHero.setImage(url: imageURL)
        }
        
        
        
        
    }
}
