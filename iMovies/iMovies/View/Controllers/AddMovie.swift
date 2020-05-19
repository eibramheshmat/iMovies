//
//  AddMovie.swift
//  iMovies
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import CoreData

class AddMovie: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    // outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var overviewTxt: UITextView!
    @IBOutlet weak var saveDesign: UIButton!
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate) /// for coredata
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // redesign objects for corner reduis and borders
        designObject(object: overviewTxt, cornerRadius: 10, borderWidth: 0.3, borderColor: UIColor.gray.cgColor)/// method is extensions of UIViewController
        designObject(object: saveDesign, cornerRadius: 10, borderWidth: 0.3, borderColor: UIColor.gray.cgColor)/// method is extensions of UIViewController
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        overviewTxt.text = "" ///when start editing i remove placeholder which is text
    }
    
    // start picking image from gallery
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // after finished picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// set image after back of picking
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // saving in coredata
    @IBAction func save(_ sender: Any) {
        if let title = titleTxt.text, let date = dateTxt.text, let overview = overviewTxt.text{
            if title.isEmpty || date.isEmpty || overview.isEmpty || overview == "Enter overview" {
                self.showAlert(title: "Error", message: "Please fill all fields")
            }else{
                if date.validateDate(date: date){
                    let managmentContext = appDelegate.persistentContainer.viewContext
                    let movie = NSEntityDescription.insertNewObject(forEntityName: "Movies", into: managmentContext)
                    let data = (imageView.image)!.pngData()
                    movie.setValue(data, forKey: "image")
                    movie.setValue(titleTxt.text, forKey: "title")
                    movie.setValue(dateTxt.text, forKey: "relasedate")
                    movie.setValue(overviewTxt.text, forKey: "overview")
                    do{
                        try managmentContext.save()
                        self.showAlert(title: "Success", message: "Adding done!")
                        print("saved")
                    }catch let error  as NSError {
                        print("couldn't save .\(error), \(error.userInfo)")
                    }
                }else{
                    self.showAlert(title: "Error", message: "Please enter date like : 2020-05-20 year-month-day")
                }
            }
        }
        
        
    }
    

}
