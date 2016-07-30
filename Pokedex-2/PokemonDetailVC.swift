//
//  PokemonDetailVC.swift
//  Pokedex-2
//
//  Created by Aryan Sharma on 29/07/16.
//  Copyright © 2016 hootyapps. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
            // this will be called after download is done
        }
        
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        pokedexLbl.text = "\(pokemon.pokedexId)"
        baseAttack.text = pokemon.attack
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "NO Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                
            }
            evoLbl.text = str
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
