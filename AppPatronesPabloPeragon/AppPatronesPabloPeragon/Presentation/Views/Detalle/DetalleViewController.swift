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
        viewModel.loadHeros()
        setObservers()
    }
    
    private func setObservers() {
        viewModel.modelStatusLoad = { [weak self] status in
            switch status {
            case .loading:
                print("Detalle Loading")
            case .loaded:
                DispatchQueue.main.async {
                    guard let hero = self?.viewModel.dataHeroe else {
                        self?.viewModel.modelStatusLoad?(.error)
                        return
                    }
                }
            case .error:
                print("Detalle error")
            case .none:
                print("Detalle None")
            }
            
        }
        
        func configure(whith hero: HeroModel) {
            LabelHero.text = hero.name
            DescriptionHero.text = hero.description
            
            guard let imageURL = URL(string: hero.photo) else {
                return
            }
            ImagenHero.setImage(url: imageURL)
        
        }
    }
}




