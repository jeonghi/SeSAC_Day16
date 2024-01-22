//
//  LottoEntity.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import Foundation

enum LottoEntity {
  struct Response: Codable {
    let drwNo: Int
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
  }
}
