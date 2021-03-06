//
//  Extensions.swift
//  testStructure
//
//  Created by Ibram on 11/14/19.
//  Copyright © 2019 Ibram. All rights reserved.
//

import UIKit

// MARK: -UIViewController extensions
extension UIViewController {
    
    /// to hide keyboard when click anywhere view
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// to show allert
    func showAlert(title: String, message: String) {
      let alertController = UIAlertController(title: title, message:
        message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
      }))
      self.present(alertController, animated: true, completion: nil)
    }
    
    /// for redesign object with corner raduis and border
    func designObject(object: UIView, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        object.layer.cornerRadius = cornerRadius
        object.clipsToBounds = true
        object.layer.borderWidth = borderWidth
        object.layer.borderColor = borderColor
        object.layer.masksToBounds = true
    }
}


// MARK: -Dictionary extensions
extension Dictionary {
    /// to return parameter in queryParameters shape
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            if output == "" {
                output +=  "\(key)=\(value)"
            }else{
                output +=  "&\(key)=\(value)"
            }
        }
        return output
    }
}

//MARK:- String extensions
extension String{
    func validateDate(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if dateFormatter.date(from: date) != nil {
            return true
        } else {
            return false
        }
    }
}

//MARK:- UIImageView extension
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

