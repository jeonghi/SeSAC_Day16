//
//  BeerEntity.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import Foundation

enum BeerEntity {
  struct Response: Decodable {
    let name: String
    let image_url: String
    let description: String
  }
}
