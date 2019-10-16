//
//  secondViewController.swift
//  colleges
//
//  Created by ios6 on 2/7/17.
//  Copyright © 2017 ios6. All rights reserved.
//

import UIKit
import SafariServices
import CoreLocation
import MapKit

class secondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate
{
    let picker = UIImagePickerController()
    var photos: [UIImage] = []
    var count: Int = 0
    var selectedCollege:College!
    let locationManager = CLLocationManager()
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoTextFieldTwo: UITextField!
    @IBOutlet weak var infoTextFieldThree: UITextField!
    @IBOutlet weak var webTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        infoLabel.text = selectedCollege.name
        infoTextFieldTwo.text = selectedCollege.location
        infoTextFieldThree.text = selectedCollege.numberOfStudents
        webTextField.text = selectedCollege.website
        imageView.image = selectedCollege.schoolImage
        view.backgroundColor? = selectedCollege.color
        picker.delegate = self
        count = 0
        picker.allowsEditing = true
    }
    
    @IBAction func libraryBarButton(_ sender: UIBarButtonItem)
    {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            { (action) in
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
        }))
        present(sheet, animated: true, completion: nil)
    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true)
        {
            self.photos.append(info[UIImagePickerControllerEditedImage] as! UIImage)
            self.selectedCollege.schoolImage = self.photos.first!
        }
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func animateImage()
    {
        if photos.count > 0
        {
            if count < photos.count - 1
            {
                count += 1
            }
            else
            {
                count = 0
            }
        }
        imageView.image = photos[self.count]
    }
    
    @IBAction func stretchThree(_ sender: UIButton)
    {
        let collegeLink = selectedCollege.website
        let myUrl = URL(string: collegeLink)
        UIApplication.shared.openURL(myUrl!)
    }
    
    @IBAction func locationButton(_ sender: UIButton)
    {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let nvc = segue.destination as! mapViewController
        nvc.coordinate = selectedCollege.map
        nvc.mapCollege = selectedCollege
    }
}
