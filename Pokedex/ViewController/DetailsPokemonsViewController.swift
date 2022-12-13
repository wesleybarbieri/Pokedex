//
//  DetailsPokemonsViewController.swift
//  Pokedex
//
//  Created by Wesley Camilo on 16/11/22.
//

import UIKit
import CloudKit

class DetailsPokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum Cell: String {
        case pokemon = "detailsPokemonsCell"
        case others = "othersDetails"
    }
    var viewModel: DetailsPokedexViewModel?
     
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(DetailsPokemonsTableViewCell.self, forCellReuseIdentifier: Cell.pokemon.rawValue)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.others.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.configureView()
        self.addBackground()
        self.viewModel?.getDetailPokemon({ [weak self] in
            self?.tableView.reloadData()
        })
        
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
            self.tableView.allowsSelection = false
        NSLayoutConstraint.activate([
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        
            ])
        }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        let cashier: UIView = UIView()
        if (section == 0) {
            return nil
        } else if (section == 1) {
            label.text = "Tipes"
            label.textColor = self.hexStringToUIColor(hex: "#031634")
            
        } else if (section == 2) {
            label.text = "Moves"
            label.textColor = self.hexStringToUIColor(hex: "#031634")
            
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        cashier.addSubview(label)
        NSLayoutConstraint.activate([
            cashier.topAnchor.constraint(equalTo: label.topAnchor),
            cashier.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            cashier.rightAnchor.constraint(equalTo: label.rightAnchor),
            cashier.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10)
        ])
        
        return cashier
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return viewModel?.model?.types?.count ?? 0
        } else if section == 2 {
            return viewModel?.model?.moves?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.pokemon.rawValue, for: indexPath) as? DetailsPokemonsTableViewCell
            cell?.backgroundColor = .clear
            
            cell?.name = self.viewModel?.model?.name
            cell?.height = "\(self.viewModel?.model?.height ?? 0)"
            cell?.weight = "\(self.viewModel?.model?.weight ?? 0)"
            Services().carregarImage(self.viewModel?.pokemon.avatar ?? "") { (image, _) in
                cell?.image = image
        
            }
            return cell ?? UITableViewCell()
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.others.rawValue, for: indexPath)
            cell.backgroundColor = .clear
            var cofiguration = cell.defaultContentConfiguration()
            cofiguration.textProperties.color = self.hexStringToUIColor(hex: "#076461")
            let row = indexPath.row
            if let types = viewModel?.model?.types, row < types.count {
                cofiguration.text = types[row].type?.name
            }
            cell.contentConfiguration = cofiguration
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.others.rawValue, for: indexPath)
            cell.backgroundColor = .clear
            var cofiguration = cell.defaultContentConfiguration()
            cofiguration.textProperties.color = self.hexStringToUIColor(hex: "#076461")
            let row = indexPath.row
            if let moves = viewModel?.model?.moves, row < moves.count {
                cofiguration.text = moves[row].move?.name
            }
            cell.contentConfiguration = cofiguration
            
            return cell
        }
        return UITableViewCell()
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
        
}
