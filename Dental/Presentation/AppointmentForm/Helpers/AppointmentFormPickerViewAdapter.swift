//
//  AppointmentFormPickerViewAdapter.swift
//  Dental
//
//  Created by Igor Sorokin on 04.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

final class AppointmentFormPickerViewAdapter: NSObject {
    
    // MARK: Private properties
    private let pickerView: UIPickerView
    
    // MARK: Public properties
    var onDidSelectRow: ((String) -> Void)?
    
    init(pickerView: UIPickerView) {
        self.pickerView = pickerView
    }
    
}
    
extension AppointmentFormPickerViewAdapter: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100 - 16
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(age: row + 16)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onDidSelectRow?(String(age: row + 16))
    }
}
