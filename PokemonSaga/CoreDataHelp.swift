//
//  CoreDataHelp.swift
//  PokemonSaga
//
//  Created by KR DEVARAJAN NAIR on 2017/03/20.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import CoreData


func addPokemon(){
    createPokemon(name:"Mew", image:"mew")
    createPokemon(name:"Meowth", image:"meowth")
    createPokemon(name:"Caterpie", image:"caterpie")
    createPokemon(name:"Abra", image:"abra")
    createPokemon(name:"Rattata", image:"rattata")
    createPokemon(name:"Snorlax", image:"snorlax")
    createPokemon(name:"Charmander", image:"charmander")
    createPokemon(name:"Weedle", image:"weedle")
    createPokemon(name:"Zubat", image:"zubat")
    createPokemon(name:"Venonat", image:"venonat")
}

func createPokemon(name:String,image:String)->Void{
    let context=UIApplication.shared.delegate as!AppDelegate
    let pokemon=Pokemon(context: context.persistentContainer.viewContext)
    pokemon.name=name
    pokemon.image=image
    context.saveContext()
}
func getAllPokemons()->[Pokemon]{
    let context=UIApplication.shared.delegate as!AppDelegate
    
    
    var pokemon:[Pokemon]=[]
    do{
        pokemon=try context.persistentContainer.viewContext.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        if pokemon.count==0{
            addPokemon()
            return getAllPokemons()
        }
            }catch{}
    return pokemon
}
func getAllCaught()->[Pokemon]{
    var allCaught:[Pokemon]=[]
    let context=UIApplication.shared.delegate as!AppDelegate
    let fetchRequest=Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate=NSPredicate(format: "caught==%@", true as CVarArg)
    do{
        allCaught=try context.persistentContainer.viewContext.fetch(fetchRequest)
    }catch{}
    return allCaught
}
func getAllUnCaught()->[Pokemon]{
    var allUnCaught:[Pokemon]=[]
    let context=UIApplication.shared.delegate as!AppDelegate
    let fetchRequest=Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate=NSPredicate(format: "caught==%@", false as CVarArg)
    do{
        allUnCaught=try context.persistentContainer.viewContext.fetch(fetchRequest)
    }catch{}
    return allUnCaught
    
}
