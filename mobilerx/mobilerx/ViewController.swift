//
//  ViewController.swift
//  mobilerx
//
//  Created by Landon Rohatensky on 2014-09-27.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var doc = createDoctor("Leo", "Spaceman", "General Practitioner")
        var api = ApiManager()
        api.addDoctor(doc)
        api.getDoctors()
        /*var api = ApiManager()
        api.getDoctor("C8E71C24-8A68-4687-BFB1-9B05CCF57BBD")*/
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

