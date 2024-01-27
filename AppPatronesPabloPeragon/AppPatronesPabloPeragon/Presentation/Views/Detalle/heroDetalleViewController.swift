//
//  heroDetailViewController.swift
//  practicaDragonBall
//
//  Created by Pablo Jesús Peragón Garrido on 19/1/24.
//

import UIKit

final class heroDetalleViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDetailText: UITextView!
   
    
    // MARK: - Model
    private let hero: HeroModel
    
    // MARK: - Initializers
    init(hero: HeroModel) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

// MARK: - View Configuration
private extension heroDetalleViewController {
    func configureView() {
        heroNameLabel.text = hero.name
        heroDetailText.text = hero.description
        
        
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
       /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Transformations",
            style: .plain,
            target: self,
            action: #selector(navigation)
        )
        */
    }
    /*
    @objc
    func navigation(_ sender: Any) {
        
        model.getTransformation(id: hero.id) { [weak self] result in
            switch result {
            case .success(let transformations):
                DispatchQueue.main.async {
                    self?.transformations = transformations
                    let heroTransformation = HeroTransformationTableViewController(tranformation: transformations)
                    self?.navigationController?.pushViewController(heroTransformation, animated: true)
                }
                
                
                
            case .failure(let error):
                print("Error loading heroes: \(error)")
            }
     */
        }
        
        
    
