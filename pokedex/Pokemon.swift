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
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    //_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
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
            
            if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0{ //since the type is stored in an array of dictionaries we have to put [Dictionary<String, String>]
    
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                
                if types.count > 1 {
                    
                    for x in 1..<types.count {
                        if let name = types[x]["name"]{
                            self._type! += "\("/" + name.capitalized)"
                        }
                    }
                }//checking to see if there is more than one type then storing it to the existing variable
                print (self._type)
                
            }
            
            else {
                self._type = ""
            }//just in case there is no value stored in "type"
            
      //^^^^^^^^^^^getting types ^^^^^^^^^^^^^^
            if let descriptionArr = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArr.count > 0 {
    
                if let url = descriptionArr[0]["resource_uri"] {
                    
                      let descURL = "\(URL_BASE)\(url)"
                    
                    Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                        if let descDict = response.result.value as? Dictionary<String, Any> {
                            if let description = descDict["description"] as? String {
                                
                                let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                self._description = newDescription
                                print(newDescription)
                            }
                        }
                        completed()
                    })//we had to make a second alamofire call to get description from the other link
                }
            }else {
                self._description = ""
            }
            //^^^^^^^^^^^getting description^^^^^^^^^^^^^^^
            
            if let evolutions = dict["evolutions"] as? [Dictionary <String, Any>] , evolutions.count > 0 {
                
                if let nextEvo = evolutions[0]["to"] as? String {
                
                    if nextEvo.range(of: "mega") == nil {
                        self._nextEvolutionName = nextEvo
                    
                        if let uri = evolutions[0]["resource_uri"] as? String {
                            
                            let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvoID = newString.replacingOccurrences(of: "/", with: "")
                            
                            self._nextEvolutionID = nextEvoID
                            
                            if let lvlExist = evolutions[0]["level"] {
                                
                                if let lvl = lvlExist as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                                
                            }else {
                                self._nextEvolutionLevel = ""
                            }
                        }
                        
                    }//we only want to keep going if it's not mega because we do not support it at the moment
                    
                }
                print(self.nextEvolutionLevel)
                print(self.nextEvolutionName)
                print(self.nextEvolutionID)
                
            }
            
            //^^^^^^^^^^^getting evolutions^^^^^^^^^^^^^^^
        }
       
            
        //all the data we get back will be stored in "response"
        completed()
    }
    
    
}
}
