//
//  String+Extension.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import Foundation

extension String {
  func toURL() -> URL? {
    URL(string: self)
  }
}
