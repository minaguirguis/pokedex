//
//  ViewController.swift
//  pokedex
//
//  Created by Mina Guirguis on 8/15/17.
//  Copyright © 2017 Mina Guirguis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
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
            
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
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
    
    
}

