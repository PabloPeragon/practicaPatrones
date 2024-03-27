//
//  DetalleViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 28/1/24.
//

import UIKit

class DetailVeiwController: UIViewController {
    
    //IBOoutlet
    
    @IBOutlet weak var ImagenHero: UIImageView!
    @IBOutlet weak var LabelHero: UILabel!
    @IBOutlet weak var DescriptionHero: UITextView!
    
    //VeiwModel
    private var viewModel: DetailViewModel
    
    //Init
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadHero()
        setObservers()
    }
    
    private func setObservers() {
        viewModel.detailStatusLoad = { [weak self] status in
            switch(status) {
            case .loading:
                print("Cargando Detail")
            case .loaded:
                self?.updateViews()
            case .error:
                print("Error en Detail")
            case .none:
                print("None en Detail")
            }
        }
    }
    
    func updateViews() {
        update(image: viewModel.dataHeroe.photo)
        update(title: viewModel.dataHeroe.name)
        update(description: viewModel.dataHeroe.description)
    }
    
    private func update(image: String?) {
        guard let image = image else { return }
        let url = URL(string: image)
        guard let url = url else { return }
        ImagenHero.setImage(url: url)
    }
    
    private func update(title: String?) {
        LabelHero.text = title ?? "No hay nombre"
    }
    
    private func update(description: String?) {
        DescriptionHero.text = description ?? "No hay descripción"
    }
    
}




