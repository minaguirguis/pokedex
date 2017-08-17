//
//  Pokemon.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/16/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String! // we know it will exist so its okay to unrawp it with a "!"
    private var _pokedexID: Int!
    
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
