//
//  DetailPokedexViewModel.swift
//  Pokédex
//
//  Created by Wesley Camilo on 09/11/22.
//

import Foundation
class DetailsPokedexViewModel {
    let api: PokedexAPI = PokedexAPI()
    var model: DetailsPokemonModel?
    let pokemon: PokedexModel.Pokemon
    init(pokemon: PokedexModel.Pokemon) {
        self.pokemon = pokemon
    }
    func getDetailPokemon(_ completion: @escaping () -> Void) {
        self.api.getDetailsPokemon(url: self.pokemon.url ?? "") { (model) in
            self.model = model
            completion()
        }
    }
    func saveFavorite() {
        if let name = self.pokemon.name, let url =  self.pokemon.url{
            let favorite = PokemonsFavoriteModel()
            favorite.addPokemon(nome: name, avatar: url)
            }
        }
    func deleteFavorite() {
        if let name = self.pokemon.name {
            let favorite = PokemonsFavoriteModel()
            favorite.deletePokemon(nome: name)
        }
    }
    func pokemonSave() -> Bool {
        let model = PokemonsFavoriteModel()
        return model.savePokemon(nome: self.pokemon.name ?? "")
    }
}

