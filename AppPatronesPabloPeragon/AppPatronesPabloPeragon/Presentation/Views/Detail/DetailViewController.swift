//
//  DetailViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 28/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ImageDetail: UIImageView!
    @IBOutlet weak var NameDetail: UILabel!
    @IBOutlet weak var DescriptionDetail: UITextView!
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        update(name: viewModel.dataHeroe.name)
        update(description: viewModel.dataHeroe.description)
    }
    
    private func update(image: String?) {
        guard let image = image else { return }
        let url = URL(string: image)
        guard let url = url else { return }
        ImageDetail.setImage(url: url)
    }
    
    private func update(name: String?) {
        NameDetail.text = name ?? "No hay nombre"
    }
    
    private func update(description: String?) {
        DescriptionDetail.text = description ?? "No hay text"
    }
}
