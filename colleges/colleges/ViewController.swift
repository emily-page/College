//
//  ViewController.swift
//  colleges
//
//  Created by ios6 on 2/7/17.
//  Copyright © 2017 ios6. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    var colleges = [College]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let collegeOne = College(n: "University of Illinois", l: "Champaign-Urbana, Illinois", s: "1,234", i: UIImage(named: "illinois")!, w: "http://illinois.edu/", m: CLLocationCoordinate2DMake(40.1020, -88.2272), c: UIImage(named: "illinoisCrest")!, o: UIColor.orange)
        let collegeTwo = College(n: "University of Florida", l: "Florida", s: "2,345", i: UIImage(named: "florida")!, w: "http://www.ufl.edu/", m: CLLocationCoordinate2DMake(29.6436, -82.3549), c: UIImage(named: "floridaCrest")!, o: UIColor.blue)
        let collegeThree = College(n: "The Ohio State University", l: "Ohio", s: "3,456", i: UIImage(named: "ohio")!, w: "https://www.osu.edu/", m: CLLocationCoordinate2DMake(40.0142, -83.0309), c: UIImage(named: "ohioCrest")!, o: UIColor.red)
        colleges.append(collegeOne)
        colleges.append(collegeTwo)
        colleges.append(collegeThree)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = colleges[indexPath.row].name
        cell.detailTextLabel?.text = colleges[indexPath.row].location
        cell.imageView!.image = colleges[indexPath.row].schoolImage
        //myTableView.backgroundColor = UIColor.purple
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            colleges.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
    @IBAction func editBarButton(_ sender: UIBarButtonItem)
    {
        if sender.tag == 0
        {
            myTableView.isEditing = true
            sender.tag = 1
        }
        else
        {
            myTableView.isEditing = false
            sender.tag = 0
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath)
    {
        let itemToMove = colleges[fromIndexPath.row]
        colleges.remove(at: fromIndexPath.row)
        colleges.insert(itemToMove, at: toIndexPath.row)
        myTableView.reloadData()
    }
    
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let nvc = segue.destination as! secondViewController
        let indexPath = myTableView.indexPathForSelectedRow
        nvc.selectedCollege = colleges[(indexPath?.row)!]
    }
    
    @IBAction func addButton(_ sender: AnyObject)
    {
        let alert = UIAlertController(title: "Add a College", message: "Enter Info", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "College Name" })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "College City" })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Number of Students" })
        alert.addTextField(configurationHandler: { (textfield) -> Void in textfield.placeholder = "College Website"})
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let nameTextField = alert.textFields![0]
            let locationTextField = alert.textFields![1]
            let numberTextField = alert.textFields![2]
            let websiteTextField = alert.textFields![3]
            let newCollege = College(n: nameTextField.text!, l: locationTextField.text!, s: numberTextField.text!, i: UIImage(), w: "https://" + websiteTextField.text!, m: CLLocationCoordinate2D(), c: UIImage(), o: UIColor.white)
            self.colleges.append(newCollege)
            self.myTableView.reloadData()
            print("Text field: \(newCollege)")
            }))
        
        self.present(alert, animated: true, completion: nil)
        myTableView.reloadData()
    }
}
