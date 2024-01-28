//
//  HomeTableViewController.swift
//  AppPatronesPabloPeragon
//
//  Created by Pablo Jesús Peragón Garrido on 24/1/24.
//

import UIKit

final class HomeTableViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    //ViewModel
    private var homeViewModel: HomeViewModel
    
    //Init
    init(homeViewModel: HomeViewModel = HomeViewModel()) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        tableViewOutlet.register(UINib(nibName: "characterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        homeViewModel.loadHeros()
        setObservers()
    }
    
    //Conectar-Escuchar-Variable Estado ViewModel
    private func setObservers() {
        homeViewModel.homeStatusLoad = { [weak self] status in
            switch status {
            case .loading:
                print("Home Loadion")
            case .loaded:
                self?.tableViewOutlet.reloadData()
            case .error:
                print("Home Error")
            case .none:
                print("Home None")
            }
        }
    }
}

//MARK: - Extension Delegate
extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Navegar al detalle
        let nextVM = HeroDetalleModel()
        let nextVC = DetalleViewController(viewModel: nextVM)
        self.navigationController?.setViewControllers([nextVC], animated: true)
        
    }
}

//MARK: - Extension DataSource
extension HomeTableViewController: UITableViewDataSource {
    //Numero de columnas por seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.dataHeroes.count
    }
    
    //Formato de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! characterTableViewCell
        cell.configure(with: homeViewModel.dataHeroes[indexPath.row])
        return cell
    }

    
}
