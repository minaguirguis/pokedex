//
//  PokeCell.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/17/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    //calling the things we want to modify
    
    var pokemon: Pokemon!
    //creating a class and giving it the type Pokemon
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    //adding rounded corners
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        //updating the text so it becomes pokemons name 
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        //since pokedexID is a number we converted it into a string
    }
    //a function that updates the contents of each collection view cell
    
    
    
}


