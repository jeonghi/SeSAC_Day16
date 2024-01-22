//
//  RandomBeerViewController.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import UIKit
import Kingfisher

class RandomBeerViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var beerTitleLabel: UILabel!
  @IBOutlet weak var beerDescriptionLabel: UILabel!
  @IBOutlet weak var randomButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    callAPI()
  }
  
  func configUI(){
    beerTitleLabel.text = "맥주이름"
    beerDescriptionLabel.text = "맥주 설명"
    beerDescriptionLabel.numberOfLines = .max
    randomButton.setTitle("다른 맥주 추천받기", for: .normal)
    randomButton.setTitleColor(.orange, for: .normal)
  }
  
  @IBAction func tappedRandomButton(_ sender: Any) {
    callAPI()
  }
  
  func updateUI(_ beer: BeerEntity.Response){
    beerTitleLabel.text = beer.name
    beerDescriptionLabel.text = beer.description
    imageView.kf.setImage(with: beer.image_url.toURL())
  }
  
  func callAPI(){
    APIService.beerService.callRequest(isRandomly: true) { res in
      switch res {
      case .success(let beers):
        dump(beers)
        guard let beer = beers.first else {
          return
        }
        self.updateUI(beer)
      case .failure(let error):
        dump(error)
      }
    }
  }
}
