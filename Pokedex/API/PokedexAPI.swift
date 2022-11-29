//
//  PokédexAPI.swift
//  Pokédex
//
//  Created by Wesley Camilo on 08/11/22.
//

import Foundation
class PokedexAPI {
    struct Resource {
        private static var url: String { return "https://pokeapi.co/api/v2/"}
        static var listPokemon: String {return Resource.url + "/pokemon"}
    }
    func listPokemon(_ completion: @escaping (PokedexModel?) -> Void) {
        let api = Services()
        api.request(Resource.listPokemon) { (result: PokedexModel?, erro) in
            completion(result)
        }
    }
    
    func getDetailsPokemon(url: String, _ completion: @escaping (DetailsPokemonModel?) -> Void) {
        let api = Services()
        api.request(url) { (result: DetailsPokemonModel?, erro) in
            completion(result )
        }
    }
}
