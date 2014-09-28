//
//  File.swift
//  mobilerx
//
//  Created by Kyle Smyth on 2014-09-27.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//

import Foundation

public func createPatient(firstName : String, lastName : String, healthCardNumber : String) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["firstName"] = firstName
    d["lastName"] = lastName
    d["healthCardNumber"] = healthCardNumber
    /*d["emergencyContacts"] = emergencyContacts
    d["allergies"] = allergies
    d["previousMedicalProcedures"] = previousMedicalProcedures*/
    return d
}

func createPatient(id : String,
firstName : String, lastName : String, healthCardNumber : Int, emergencyContacts : [Dictionary<String, AnyObject>]?, allergies : [String]?, previousMedicalProcedures : [String]?) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["id"] = id
    d["firstName"] = firstName
    d["lastName"] = lastName
    d["healthCardNumber"] = healthCardNumber
    d["emergencyContacts"] = emergencyContacts
    d["allergies"] = allergies
    d["previousMedicalProcedures"] = previousMedicalProcedures
    return d
}

func createEmergencyContact(firstName : String, lastName : String, phoneNumber : String, relationship : String) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["firstName"] = firstName
    d["lastName"] = lastName
    d["phoneNumber"] = phoneNumber
    d["relationship"] = relationship
    
    return d
}

func createDoctor(firstName : String, lastName : String, type: String) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["firstName"] = firstName
    d["lastName"] = lastName
    d["type"] = type
    return d
}

func createDoctor(firstName : String, lastName : String, type: String, id : String) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["id"] = NSUUID.UUID().UUIDString
    d["firstName"] = firstName
    d["lastName"] = lastName
    d["type"] = type
    return d
}


func createDrug(name : String, number : Int, mass : Double, packageQuantity : Int) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["name"] = name
    d["number"] = number
    d["mass"] = mass
    d["packageQuantity"] = packageQuantity
    return d
}

func createWorkOrder(patientId: String, pharmId : String, image : String) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["patientId"] = patientId
    d["pharmId"] = pharmId
    d["image"] = image
    return d
}

func createPrescription(id : String, doctorId : String, patientId : String, status : Int, drugs : [Dictionary<String,AnyObject>]) -> Dictionary<String, AnyObject> {
    var d = Dictionary<String, AnyObject>()
    d["id"] = id
    d["patientId"] = patientId
    d["doctorId"] = doctorId
    d["status"] = status
    d["drugs"] = drugs
    return d
}