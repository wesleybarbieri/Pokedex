//
//  PokemonsViewController.swift
//  Pokédex
//
//  Created by Wesley Camilo on 10/11/22.
//

import UIKit
import Foundation
class PokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum Cell: String {
    case pokemon = "pokemoncell"
    }
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: PokedexViewModel = PokedexViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.tableView.register(PokemonsTableViewCell.self, forCellReuseIdentifier: Cell.pokemon.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.configureView()
        self.viewModel.getPokemons { [self] in
            self.tableView.reloadData()
        }
        
    }
    private func addBackground(){
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
        private func configureView() {
            self.view.addSubview(self.tableView)
            self.tableView.backgroundColor = .clear
            self.tableView.separatorStyle = .none
            
            
        NSLayoutConstraint.activate([
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            
        ])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let row = indexPath.row
        if let model = self.viewModel.model, row < model.results.count {
            let pokemon = model.results[row]
            let viewController = DetailsPokemonsViewController()
            let viewModel = DetailsPokedexViewModel(pokemon: pokemon)
            viewController.viewModel = viewModel
            self.navigationController?.pushViewController(viewController, animated: true)
            //self.present(viewController, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.pokemon.rawValue , for: indexPath) as? PokemonsTableViewCell
        cell?.backgroundColor = .clear
        let row = indexPath.row
        if let model = self.viewModel.model, row < model.results.count {
            let pokemon = model.results[row]
            cell?.name = pokemon.name
            Services().carregarImage(pokemon.avatar ?? "") { success, error in
                cell?.icon = success
            }
            
        }
        
        return cell ?? UITableViewCell()
    }
}
