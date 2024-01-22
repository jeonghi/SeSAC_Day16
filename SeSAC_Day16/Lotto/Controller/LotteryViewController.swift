//
//  ViewController.swift
//
//  Created by 쩡화니 on 1/16/24.
//  Copyright © 2024 com.jeonghi. All rights reserved.
//

import UIKit

class LotteryViewController: UIViewController {
  
  @IBOutlet weak var sevenLabel: UILabel!
  @IBOutlet weak var sixLabel: UILabel!
  @IBOutlet weak var fiveLabel: UILabel!
  @IBOutlet weak var fourLabel: UILabel!
  @IBOutlet weak var threeLabel: UILabel!
  @IBOutlet weak var twoLabel: UILabel!
  @IBOutlet weak var oneLabel: UILabel!
  
  @IBOutlet weak var textField: UITextField!
  
  var lottoPickerView: UIPickerView = .init()
  let numberList: [Int] = Array(1...1102).reversed()
  
  lazy var labelList: [UILabel] = [oneLabel, twoLabel, threeLabel, fourLabel, fiveLabel, sixLabel, sevenLabel]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    configTextField()
    configPicker()
    callAPI()
  }
  
  @IBAction func tappedAroundView(_ sender: Any) {
    view.endEditing(true)
  }
  
  func configUI(){
    labelList.forEach {
      $0.layer.cornerRadius = 6
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.black.cgColor
    }
  }
  
  func updateLottoNumberLabel(_ lotto: LottoEntity.Response){
    oneLabel.text = lotto.drwtNo1.toString()
    twoLabel.text = lotto.drwtNo2.toString()
    threeLabel.text = lotto.drwtNo3.toString()
    fourLabel.text = lotto.drwtNo4.toString()
    fiveLabel.text = lotto.drwtNo5.toString()
    sixLabel.text = lotto.drwtNo6.toString()
    sevenLabel.text = lotto.bnusNo.toString()
  }
}

extension LotteryViewController: UITextFieldDelegate {
  func configTextField(){
    self.textField.delegate = self
    self.textField.tintColor = .clear
    self.textField.inputView = lottoPickerView
    self.textField.text = numberList.first?.toString()
  }
  
  func textFieldDidChangeSelection(_ textField: UITextField) {
    return
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    callAPI()
  }
  
  func callAPI(){
    guard let text = textField.text, let drwNo = Int(text) else{
      return
    }
    APIService.lottoService.callRequest(drwNo: drwNo){ res in
      switch res {
      case .success(let lotto):
        dump(lotto)
        self.updateLottoNumberLabel(lotto)
      case .failure(let error):
        dump(error)
      }
    }
  }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func configPicker(){
    lottoPickerView.delegate = self
    lottoPickerView.delegate = self
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return numberList.count
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    textField.text = "\(numberList[row])"
    callAPI()
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "\(numberList[row])회차"
  }
}

