//
//  DetailsPokemonModel.swift
//  Pokédex
//
//  Created by Wesley Camilo on 08/11/22.
//

import Foundation
struct DetailsPokemonModel: Decodable {
    var height: Int?
    var name: String?
    var weight: Int?
    var moves: Array<Moves>?
    var types: Array<Types>?
    
    struct Types: Decodable{
        var type: Type?
        
        struct `Type`: Decodable {
            var name: String
        }
    }
    
    struct Moves: Decodable {
        var move: Move?
        
        struct Move: Decodable {
            var nome: String
        }
    }
}
