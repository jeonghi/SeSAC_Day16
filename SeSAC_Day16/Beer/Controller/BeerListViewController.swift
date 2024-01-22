//
//  BeerListViewController.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import UIKit

class BeerListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var beerList: [BeerEntity.Response]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    configNavbarItem()
    APIService.beerService.callRequest { res in
      switch res {
      case .success(let beers):
        self.beerList = beers
        self.tableView.reloadData()
      case .failure(let error):
        dump(error)
      }
    }
  }
  func configUI(){
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func configNavbarItem(){
    self.navigationItem.rightBarButtonItem = .init(title: "랜덤", style: .plain, target: self, action: #selector(tappedRandomButton))
  }
  
  @objc func tappedRandomButton(_ sender: Any){
    let sb = UIStoryboard(name: RandomBeerViewController.identifier, bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: RandomBeerViewController.identifier)
    present(vc, animated: true)
  }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    beerList?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let idx = indexPath.row
    guard let beer = beerList?[idx] else {
      return .init()
    }
    let xib = UINib(nibName: BeerTableViewCell.identifier, bundle: nil)
    tableView.register(xib, forCellReuseIdentifier: BeerTableViewCell.identifier)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else {
      return .init()
    }
    cell.setModel(beer)
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
