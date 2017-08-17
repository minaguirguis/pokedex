//
//  ViewController.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/15/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = Pokemon(name: "Pokemon", pokedexID: indexPath.row)
            cell.configureCell(pokemon: pokemon)
            //created a new object and configured it into cell
            return cell
            
        }else {
            return UICollectionViewCell()
        }
        //we are creating a function to reuse cells since there is 718 pokemon
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    //function responsible for when the user taps the cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  30
    }
    //this returns how many items in the collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //this is the number of sections in the collection view

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
}

