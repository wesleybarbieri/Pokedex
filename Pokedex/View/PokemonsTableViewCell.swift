//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Wesley Camilo on 14/11/22.
//

import UIKit
import Foundation
class PokemonsTableViewCell: UITableViewCell {
    
    private lazy var pokeImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var pokeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    var icon: UIImage? {
        get{
            return self.pokeImageView.image
        }
        set{
            self.pokeImageView.image = newValue
        }
    }
    var name: String? {
        get {
            return self.pokeLabel.text
        }
        set {
            return self.pokeLabel.text = newValue
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureCell()
    }
    
    private func configureCell() {
        self.contentView.addSubview(self.pokeImageView)
        self.contentView.addSubview(self.pokeLabel)
        self.pokeLabel.textColor = self.hexStringToUIColor(hex: "#076461")
        
        NSLayoutConstraint.activate([
            self.pokeImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.pokeImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.pokeImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.pokeImageView.widthAnchor.constraint(equalToConstant: 60),
            self.pokeImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.pokeLabel.topAnchor.constraint(equalTo: self.pokeImageView.topAnchor, constant: 20),
            self.pokeLabel.leftAnchor.constraint(equalTo: self.pokeImageView.rightAnchor, constant: 10)
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
