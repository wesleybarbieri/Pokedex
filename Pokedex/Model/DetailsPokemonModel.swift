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
    
    enum CodingKeys: String, CodingKey {
        case height
        case name
        case weight
        case moves
        case types
    }
    init(from decoder: Decoder) throws {
        let value = try? decoder.container(keyedBy: CodingKeys.self)
        self.height = try? value?.decode(Int.self, forKey: .height)
        self.name = try? value?.decode(String.self, forKey: .name)
        self.weight = try? value?.decode(Int.self, forKey: .weight)
        self.moves = try? value?.decode(Array<Moves>.self, forKey: .moves)
        self.types = try? value?.decode(Array<Types>.self, forKey: .types)
    }
    struct Types: Decodable{
        var type: Type?
        
        struct `Type`: Decodable {
            var name: String
        }
    }
    
    struct Moves: Decodable {
        var move: Move?
        
        struct Move: Decodable {
            var name: String
        }
    }
}
