//
//  Pokecell.swift
//  Pokedex-2
//
//  Created by Aryan Sharma on 29/07/16.
//  Copyright © 2016 hootyapps. All rights reserved.
//

import UIKit

class Pokecell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
}
