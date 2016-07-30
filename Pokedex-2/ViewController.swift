//
//  ViewController.swift
//  Pokedex-2
//
//  Created by Aryan Sharma on 29/07/16.
//  Copyright © 2016 hootyapps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    //array of pokemons to used while parsing
    var pokemon = [Pokemon]()
    // to play music
    var musicPlayer: AVAudioPlayer!
    // to search for pokemons
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        parsePokemonCSV()
        initAudio()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            // to dismiss keyboard
            view.endEditing(true)
            collection.reloadData()
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            // $0 is like a var that holds the pokemon being grabbed while filtering
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            // refresh the collectionView
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //   self.searchBar.endEditing(true)
        self.view.endEditing(true)
        //   self.collection.endEditing(true)
    }
    
    // function to parse csv file
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row ["identifier"]!
                // create pokemon instance and add to the array created earlier
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    // to play audio
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //let pokemon = Pokemon(name: "Test", pokedexId: indexPath.row)
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Pokecell", forIndexPath: indexPath) as? Pokecell {
            let poke: Pokemon!
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicButtonPressed(sender: UIButton) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        }else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }

}

