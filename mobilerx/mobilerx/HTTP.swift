//
//  api.swift
//  retail-catalog-rest-test
//
//  Created by Kyle Smyth on 2014-08-08.
//  Copyright (c) 2014 Kyle Smyth. All rights reserved.
//

import Foundation

public var api = HTTP()

public class HTTP : NSObject {
    
    //THIS GUY SHOULD BE PRIVATE AFTER REFACTORING
    func makeHTTPRequest(request : NSMutableURLRequest, callback: (NSData) -> Void) {
        var session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error ->
            Void in
            
            //println(data)
            //println(response)
            //println(error)
            
            if((error) != nil) {
                println(error.localizedDescription)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(data)
            })
            
        })
        task.resume()
        
    }
    
    func createGetRequest(URL : NSURL) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        
        return createRequest(request)
    }
    
    func createPostRequest(URL : NSURL, data : Dictionary<String, AnyObject>) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: nil)
        return createRequest(request)
    }
    
    func createDeleteRequest(URL : NSURL) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "DELETE"
        /*request.HTTPBody = NSJSONSerialization.dataWithJSONObject([], options: NSJSONWritingOptions.allZeros, error: nil)*/
        return createRequest(request)
    }
    
    func createRequest(request : NSMutableURLRequest) -> NSMutableURLRequest {
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func makeRequest(request : NSMutableURLRequest, callback : (Array<AnyObject>) -> Void) {
        
        api.makeHTTPRequest(request, callback: { (results : NSData) -> Void in
            var err : NSError?
            
            if results.length != 0 {
                var jsonResults = NSJSONSerialization.JSONObjectWithData(results, options: NSJSONReadingOptions.MutableContainers, error: &err) as Array<AnyObject>
                callback(jsonResults)
            }
            else {
                var jsonResults: NSArray = NSArray()
                callback(jsonResults)
            }
        })
        
    }
    
    func makeRequest(request : NSMutableURLRequest, callback : (Dictionary<String, AnyObject>) -> Void) {
        api.makeHTTPRequest(request, callback: { (results : NSData) -> Void in
            var err : NSError?
            if results.length != 0 {
                var jsonResults = NSJSONSerialization.JSONObjectWithData(results, options: NSJSONReadingOptions.MutableContainers, error: &err) as Dictionary<String, AnyObject>
                callback(jsonResults)
            }
            else {
                var jsonResults: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
                callback(jsonResults)
            }
            
        })
    }
}

