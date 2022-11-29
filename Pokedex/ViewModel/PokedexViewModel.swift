//
//  PokedexViewModel.swift
//  Pokédex
//
//  Created by Wesley Camilo on 09/11/22.
//

import Foundation
class PokedexViewModel {
    var model: PokedexModel?
    func getPokemons(_ completion: @escaping () -> Void)  {
        let api = PokedexAPI()
        api.listPokemon { result in
            self.model = result
            completion()
        }
    }
}
