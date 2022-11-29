//
//  PokedexModel.swift
//  Pokédex
//
//  Created by Wesley Camilo on 08/11/22.
//

import Foundation
struct PokedexModel: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Pokemon]
    
    struct Pokemon: Decodable{
        var name: String?
        var url: String?
        var avatar: String?
        init(from decoder: Decoder) throws {
            let value = try? decoder.container(keyedBy: CodingKeys.self)
            self.name = try? value?.decode(String.self, forKey: .name)
            self.url = try? value?.decode(String.self, forKey: .url)
            if let url = self.url {
                let id = String(url.suffix(2)).replacingOccurrences(of: "/", with: "")
                self.avatar = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
            }
        }
        enum CodingKeys: String, CodingKey {
            case name
            case url
        }
    }
}
