//
//  Pokemon.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/16/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon {
    
    fileprivate var _name: String! // we know it will exist so its okay to unwrap it with a "!"
    fileprivate var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    //_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    
    
    var attack: String {
        if _attack == nil {
           _attack = ""
        }
        return _attack
    }
    
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    //this is data protection
    
    
    
    
    var name: String {
        
        return _name
    }
    
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    //^^creating getters
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    //intilizing the variables
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        //passing in closure for our function
        

        Alamofire.request(_pokemonURL).responseJSON { (response) in
        //^^network request
            
          if let dict = response.result.value as? Dictionary<String, AnyObject> {
            //storing response in dictionary
            
            
            
            //creating additional if let statments to extract data
            if let weight = dict["weight"] as? String {
                self._weight = weight
            }
            //we are going into the dictionary to find "weight" and casting whatever value that ends up being as a string and storing it in a new a variable
            
            if let height = dict["height"] as? String {
                self._height = height
            }
            
            if let attack = dict["attack"] as? Int {
                self._attack = "\(attack)"
            }
            
            if let defense = dict["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            print(self._weight)
            print(self._height)
            print(self._attack)
            print(self._defense)
        }
        //declaring variable in which it will access the JSON of the api we just called
            
            
            
        //all the data we get back will be stored in "response"
        
        completed()
        
    }
    
    
}
}
