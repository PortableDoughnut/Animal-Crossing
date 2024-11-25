//
//  VillagerTableViewCell.swift
//  Animal Crossing
//
//  Created by Gwen Thelin on 11/25/24.
//

import UIKit
import Kingfisher

class VillagerTableViewCell: UITableViewCell {
	@IBOutlet weak var villagerBirthdayLabel: UILabel!
	@IBOutlet weak var villagerSpeciesLabel: UILabel!
	@IBOutlet weak var villagerPersonalityLabel: UILabel!
	@IBOutlet weak var villagerNameLabel: UILabel!
	@IBOutlet weak var villagerImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(with villager: Villager) {
		villagerNameLabel.text = villager.name
		villagerSpeciesLabel.text = villager.species
		villagerPersonalityLabel.text = villager.personality
		villagerBirthdayLabel.text = villager.birthMonth.description
		villagerImageView.kf.setImage(with: villager.imageURL)
	}

}
