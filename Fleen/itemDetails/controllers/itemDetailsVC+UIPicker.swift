//
//  itemDetailsVC+UIPicker.swift
//  Fleen
//
//  Created by Mina Eid on 06/02/2024.
//

import UIKit

extension ItemDetailsViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return countries.count
        } else {
            return selectedCountryDegress.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return countries[row].name
        } else {
            return selectedCountryDegress[row].name
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedCountryDegress = countries[row].degrees ?? []
            pickerView.reloadComponent(1)
            
            if let countryID = countries[row].id {
                print("Selected Country ID: \(countryID)")
                self.countryID = countryID
            }
        } else {
            if let degreeID = selectedCountryDegress[row].id {
                self.degreeID = degreeID
                print("Selected Degree ID: \(degreeID)")
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString?
        if component == 0 {
            let countryName = countries[row].name ?? ""
            attributedString = NSAttributedString(string: countryName, attributes: [NSAttributedString.Key.font:  UIFont(name: "DMSans18pt-Regular", size: 14)!])
        } else {
            let degreeName = selectedCountryDegress[row].name ?? ""
            attributedString = NSAttributedString(string: degreeName, attributes: [NSAttributedString.Key.font:  UIFont(name: "DMSans18pt-Regular", size: 14)!])
        }
        return attributedString
    }
    
}
