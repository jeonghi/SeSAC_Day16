//
//  LottoService.swift
//  SeSAC_Day16
//
//  Created by 쩡화니 on 1/21/24.
//

import Alamofire
import Foundation

class LottoService {
  
  static let shared = LottoService()
  
  private init() {}
  
  func callRequest(drwNo: Int, completion: @escaping (Result<LottoEntity.Response, NetworkError>) -> Void){
    
    let baseURL = "https://www.dhlottery.co.kr/common.do"
    let params: Parameters = [
      "method" : "getLottoNumber",
      "drwNo" : drwNo
    ]
    
    if let url = try? URLRequest(url: baseURL, method: .get, headers: nil).asURLRequest().url?.absoluteString {
      print("Request URL: \(url)") // URL을 출력
    }
    
    AF
      .request(
        baseURL,
        method: .get,
        parameters: params,
        encoding: URLEncoding.default
      )
      .responseDecodable(of: LottoEntity.Response.self) { res in
        switch res.result {
        case .success(let success):
          completion(.success(success))
        case .failure(let error):
          guard let data = res.data, let response = res.response else {
            print(res.data)
            completion(.failure(.unknown("알 수 없는 에러")))
            return
          }
          completion(.failure(NetworkError.checkError(data: data, response: response) ?? .unknown("알 수 없는 에러")))
        }
      }
  }
}
