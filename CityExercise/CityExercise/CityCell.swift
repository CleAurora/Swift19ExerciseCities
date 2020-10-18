//
//  CityCell.swift
//  CityExercise
//
//  Created by Cleís Aurora Pereira on 15/10/20.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var coutryLabel: UILabel!


    func setup(city: City){
        nameLabel.text = city.name
        stateLabel.text = city.state
        coutryLabel.text = city.country
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
