//
//  PokemonsViewController.swift
//  Pokédex
//
//  Created by Wesley Camilo on 10/11/22.
//

import UIKit

class PokemonsViewController: UIViewController {
    var viewModel: PokedexViewModel = PokedexViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getPokemons { [self] in
            print(viewModel)  
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
