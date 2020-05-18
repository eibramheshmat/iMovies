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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var overviewTxt: UITextView!
    @IBOutlet weak var saveDesign: UIButton!
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designObject(object: overviewTxt)
        designObject(object: saveDesign)
        // Do any additional setup after loading the view.
    }
    
    func designObject(object: UIView) {
        object.layer.cornerRadius = 10
        object.clipsToBounds = true
        object.layer.borderWidth = 0.3
        object.layer.borderColor = UIColor.gray.cgColor
        object.layer.masksToBounds = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        overviewTxt.text = ""
    }
    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        if let title = titleTxt.text, let date = dateTxt.text, let overview = overviewTxt.text{
            if title.isEmpty || date.isEmpty || overview.isEmpty || overview == "Enter overview" {
                self.showAlert(title: "Error", message: "Please fill all fields")
            }else{
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
               
            }
        }
        
        
    }
    

}
