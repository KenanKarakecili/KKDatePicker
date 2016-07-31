//
//  DatePicker.swift
//  Motto
//
//  Created by Kenan Karakecili on 26/04/16.
//  Copyright © 2016 Magis Technology. All rights reserved.
//

import UIKit

protocol KKDatePickerDelegate {
  func datePickerDidSelectAction(date: String)
}

class KKDatePicker: UIDatePicker {
  
  private let dateFormatter = NSDateFormatter()
  private let toolbar = UIToolbar()
  var field: UITextField!
  var delegate: KKDatePickerDelegate?
  
  func setupToolbar() {
    toolbar.barStyle = .Default
    toolbar.tintColor = UIColor.greenColor()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Tamam", style: .Plain, target: self, action: #selector(doneButtonAction))
    let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "İptal", style: .Plain, target: self, action: #selector(cancelButtonAction))
    toolbar.setItems([cancelButton, space, doneButton], animated: false)
  }
  
  func setup(field: UITextField, minDate: AnyObject?, maxDate: AnyObject?, mode: UIDatePickerMode) {
    backgroundColor = .groupTableViewBackgroundColor()
    setupToolbar()
    self.field = field
    datePickerMode = mode
    field.inputView = self
    field.inputAccessoryView = toolbar
    field.tintColor = .clearColor()
    switch mode {
    case .Date:
      dateFormatter.dateFormat = "dd/MM/yyyy"
    case .Time:
      dateFormatter.dateFormat = "HH:mm"
    case .DateAndTime:
      dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    default:
      break
    }
    minuteInterval = 15
    if field.text != "" {
      if let myDate = dateFormatter.dateFromString(field.text!) {
        date = myDate
      }
    }
    setMinDate(minDate)
    setMaxDate(maxDate)
  }
  
  private func setMinDate(minDate: AnyObject?) {
    guard let myMinDate = minDate else { minimumDate = nil; return }
    if myMinDate is String {
      minimumDate = dateFormatter.dateFromString(myMinDate as! String)
    } else {
      minimumDate = myMinDate as? NSDate
    }
  }
  
  private func setMaxDate(maxDate: AnyObject?) {
    guard let myMaxDate = maxDate else { maximumDate = nil; return }
    if myMaxDate is String {
      maximumDate = dateFormatter.dateFromString(myMaxDate as! String)
    } else {
      maximumDate = myMaxDate as? NSDate
    }
  }
  
  @objc private func doneButtonAction() {
    delegate!.datePickerDidSelectAction(dateFormatter.stringFromDate(date))
    field.resignFirstResponder()
  }
  
  @objc private func cancelButtonAction() {
    field.resignFirstResponder()
  }
  
}
