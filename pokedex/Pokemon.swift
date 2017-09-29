//
//  Pokemon.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/16/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import Foundation

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
    
    
    var name: String {
        
        return _name
    }
    //creating getters 
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
    }
    //intilizing the variables
    
}
