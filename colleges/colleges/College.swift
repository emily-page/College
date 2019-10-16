//
//  College.swift
//  colleges
//
//  Created by ios6 on 2/7/17.
//  Copyright © 2017 ios6. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class College: NSObject, CLLocationManagerDelegate, MKMapViewDelegate
{
    var name: String = ""
    var location: String = ""
    var numberOfStudents: String = ""
    var schoolImage: UIImage
    var website: String
    var map: CLLocationCoordinate2D
    var crest: UIImage
    var color: UIColor
    
    init(n: String, l: String, s: String, i: UIImage, w: String, m: CLLocationCoordinate2D, c: UIImage, o: UIColor)
    {
        name = n
        location = l
        numberOfStudents = s
        schoolImage = i
        website = w
        map = m
        crest = c
        color = o
    }
}
