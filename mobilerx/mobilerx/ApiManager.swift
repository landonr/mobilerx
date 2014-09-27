//
//  ApiManager.swift
//  mobilerx
//
//  Created by Kyle Smyth on 2014-09-27.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//

import Foundation

class ApiManager {
    
    let fb : String = "https://amber-inferno-3172.firebaseio.com/"
    
    func addDoctor(doctor : Dictionary<String, AnyObject>) {
        let url = fb + "doctors.json"
        let request = api.createPostRequest(NSURL(string: url), data: doctor)
        api.makeRequest(request, callback: { (result : Dictionary<String, AnyObject>) -> Void in
            println(result)
        })
    }
    
    func getDoctors() {
        let url = fb + "doctors.json"
        let request = api.createGetRequest(NSURL(string: url))
        api.makeRequest(request, callback: { (results: Dictionary<String, AnyObject>) -> Void in
            println(results)
        })
    }

    func addPatient(patient : Dictionary<String, AnyObject>) {
        let url = fb + "patients.json"
        let request = api.createPostRequest(NSURL(string: url), data: patient)
        api.makeRequest(request, callback: { (result : Dictionary<String, AnyObject>) -> Void in
            println(result)
        })
    }
    
    func getPatient(healthCard : String) {
        let url = fb + "patients.json?healthCardNumber=\(healthCard)"
        let request = api.createGetRequest(NSURL(string:url))
        api.makeRequest(request, callback: { (result : Dictionary<String, AnyObject>) -> Void in
            println(result)
        })
    }
    
    func getPharms() {
        let url = fb + "pharmacists.json"
        let request = api.createGetRequest(NSURL(string: url))
        api.makeRequest(request, callback: { (results : Dictionary<String, AnyObject>) -> Void in
            println(results)
        })

    }
    
    func postWorkOrder(work : Dictionary<String, AnyObject>) {
        let url = fb + "work_order.json"
        let request = api.createPostRequest(NSURL(string:url), data: work)
        api.makeRequest(request, callback: { (results : Dictionary<String,AnyObject>) -> Void in
            println(results)
        })
    }
    
    func getRx(id : String) {
        let url = fb + "rx.json?patientId=\(id)"
        let request = api.createGetRequest(NSURL(string:url))
        api.makeRequest(request, callback: { (result : Dictionary<String, AnyObject>) -> Void in
            println(result)
        })
    }
}
