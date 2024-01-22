//
//  BeerTableViewCell.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
  
  
  @IBOutlet var beerImageView: UIImageView!
  @IBOutlet var beerTitleLabel: UILabel!
  @IBOutlet var beerDescriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setModel(_ model: BeerEntity.Response){
    beerImageView.kf.setImage(with: model.image_url.toURL())
    beerTitleLabel.text = model.name
    beerDescriptionLabel.text = model.description
  }
}
