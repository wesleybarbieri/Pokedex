//
//  DetailsPokemonsTableViewCell.swift
//  Pokedex
//
//  Created by Wesley Camilo on 16/11/22.
//

import UIKit

class DetailsPokemonsTableViewCell: UITableViewCell {
    let color: UIColor = UIColor(red: 63, green: 184, blue: 175, alpha: 0.010)
    private lazy var pokemonImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var nameLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    private lazy var weightLabel: UILabel = {
       let view = UILabel ()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    private lazy var heightLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    var image: UIImage? {
        get {
            return self.pokemonImageView.image
        }
        set {
            self.pokemonImageView.image = newValue
        }
    }
    var name: String? {
        get {
            return self.nameLabel.text
        }
        set {
            self.nameLabel.text = newValue
        }
    }
    var weight: String? {
        get {
            return self.weightLabel.text
        }
        set {
            self.weightLabel.text = newValue
        }
    }
    var height: String? {
        get {
            return self.heightLabel.text
        }
        set {
            self.heightLabel.text =  newValue
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configuereCell()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configuereCell()
        
    }
    private func configuereCell() {
        self.contentView.addSubview(pokemonImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(weightLabel)
        self.contentView.addSubview(heightLabel)
        
        self.nameLabel.textColor = self.hexStringToUIColor(hex: "#076461")
        self.weightLabel.textColor = self.hexStringToUIColor(hex: "#076461")
        self.heightLabel.textColor = self.hexStringToUIColor(hex: "#076461")
        
        NSLayoutConstraint.activate([
            self.pokemonImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.pokemonImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.pokemonImageView.widthAnchor.constraint(equalToConstant: 60),
            self.pokemonImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            self.weightLabel.topAnchor.constraint(equalTo: self.pokemonImageView.topAnchor, constant: 0),
            self.weightLabel.leftAnchor.constraint(equalTo: self.pokemonImageView.rightAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.heightLabel.topAnchor.constraint(equalTo: self.weightLabel.bottomAnchor, constant: 10),
            self.heightLabel.leftAnchor.constraint(equalTo: self.pokemonImageView.rightAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.pokemonImageView.bottomAnchor, constant: 0),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.nameLabel.leftAnchor.constraint(equalTo: self.pokemonImageView.leftAnchor)
        ])
      
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
