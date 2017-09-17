//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Mina Guirguis on 9/15/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    //creating a variable for data to be stored into
    
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
    }

   
}
