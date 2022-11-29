//
//  PokemonsFavoriteModel.swift
//  Pokédex
//
//  Created by Wesley Camilo on 09/11/22.
//
import UIKit
import Foundation
import CoreData

class PokemonsFavoriteModel {
    var context: NSManagedObjectContext {
        get {
            return (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
        }
    }
    func addPokemon(nome: String, avatar: String) {
        let pokemon = NSEntityDescription.insertNewObject(forEntityName:
        "Pokemons", into: self.context) as? Pokemons
        pokemon?.nome = nome
        pokemon?.avatar = avatar
        do {
            try self.context.save()
        } catch  {
            
        }
    }
    func deletePokemon(nome: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemons")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "SELF.nome = %@", nome)
        if let result = try? self.context.fetch(fetchRequest).first as? NSManagedObject{
            self.context.delete(result)
        }
    }
    func savePokemon(nome: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemons")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "SELF.nome = %@", nome)
        if let result = try? self.context.fetch(fetchRequest){
            return result.count == 1
        }
        return false
    }
    func getAllPokemons() -> [Pokemons]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemons")
        if let result = try? self.context.fetch(fetchRequest) as? [Pokemons] {
            return result
        }
        return nil
    }
    
}
