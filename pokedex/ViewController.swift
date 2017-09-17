//
//  ViewController.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/15/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
       
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")! // forced unwrap because we know it exists
        
        do {
         
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            //preparing music to be played at launch
            musicPlayer.numberOfLoops = -1
            //it will loop continuously
            musicPlayer.play()
            
        }catch let err as NSError {
        
            print(err.debugDescription)
        
        }
    }
    
    //this the function that will get any of your audio ready
    
    
    
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        //creating a path to the file we want to parse
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                //force unwrapping this is fine because we have the file and we know the information is there
                
                let poke = Pokemon(name: name, pokedexID: pokeId)
                pokemon.append(poke)
                //appending this to the empty array we created above
            }
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    //we put it here so the pokemon get parsed as soon as the app loads
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            }else {
                
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            //we are setting the collectionView to show the filtered list if we are in searchMode
            
            
            cell.configureCell(poke)
            //created a new object and configured it into cell
            return cell
            
            
        }else {
            return UICollectionViewCell()
        }
        //we are creating a function to reuse cells since there is 718 pokemon
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    //function responsible for when the user taps the cell
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        
        return  pokemon.count
        //we want it as many pokemone as we have in our array
    }
    //this returns how many items in the collection view
    
    
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //this is the number of sections in the collection view
    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    //sets the size of each item
    
    
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
       
        if musicPlayer.isPlaying {
            musicPlayer.pause()
           
            sender.alpha = 0.2
            //this makes the button a little transparent when it's being pressed
            
        } else {
            
            musicPlayer.play()
            
            sender.alpha = 1.0
            //this makes the button more solid after its get pressed to play the music again
        }
        
    }
    //making a function for it to pause when button is tapped
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
        
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        }else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            // created this so we can take the text user entered and automatically make it lowercase
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            //we are saying that the filtered pokemon list is equal to the orignial pokemon list but its filtered, and are filtering it by name value of that object, and then we are saying what we put in the search bar contained inside of that name. and if it is we are going to put that int that filtered pokemon list. as long as it does not equal nil
            //$0 is a placeholder for any and all of the objects
            
            collection.reloadData()
            
        }
        //we are creating a if/else statment to tell wheather the user is in fact typing
        
    }
    //everytime we make a keystroke in the search bar whatever is in here will be called
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailsVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
    }
    //we are preparing for the segue. then we are going to be sending any object. if the segue identifier is PokeDetailVC then we are going to create variable for DetailsVC, and the destination view controller is PokedetailsVC, then are creating another variable called "poke" that is a sender and its of class pokemon. Then we use detailsVC as we defined to be destination ViewController, and then we are saying the deatilsVC that contains the variable pokemon we are setting it to this view controller's variable "poke"
}

}
