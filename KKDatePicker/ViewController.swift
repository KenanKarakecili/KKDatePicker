//
//  ViewController.swift
//  KKDatePicker
//
//  Created by Kenan Karakecili on 31/07/2016.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var dateField: UITextField!
  
  let datePicker = KKDatePicker()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    datePicker.delegate = self
  }

}

extension ViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField === dateField {
      datePicker.setup(textField,
                       minDate: NSDate(),
                       maxDate: nil,
                       mode: .DateAndTime)
    }
  }
  
}

extension ViewController: KKDatePickerDelegate {
  
  func datePickerDidSelectAction(date: String) {
    if datePicker.field === dateField {
      dateField.text = date
    }
  }
  
}
