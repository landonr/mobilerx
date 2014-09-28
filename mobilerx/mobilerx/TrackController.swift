//
//  TrackController.swift
//  mobilerx
//
//  Created by Kyle Smyth on 2014-09-28.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TrackController : UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    var name : String!
    var status : String!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var point = CLLocationCoordinate2D(latitude: 52.1298916, longitude: -106.6418334)
        var anno = address(coordinate: point, title: name, subtitle: status)
        var coord = MKCoordinateRegion(center: point, span: MKCoordinateSpan(latitudeDelta: 0.00725,longitudeDelta: 0.00725))
        
        map.setRegion(coord, animated: true)
        map.addAnnotation(anno)
        //52.1298916,-106.6417334
    }
    
}

class address : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}