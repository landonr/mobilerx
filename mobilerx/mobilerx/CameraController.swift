//
//  CameraController.swift
//  mobilerx
//
//  Created by Landon Rohatensky on 2014-09-27.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//


import UIKit

class CameraController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var imagePickerController = UIImagePickerController()
    var firstLaunch = false
    @IBOutlet var cameraTapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet var cameraButton: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    var pharmacists: NSMutableArray = []
    var myImage: UIImage!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !firstLaunch {
            firstLaunch=true
            //loadDataFromFirebase()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            {
                imagePickerController.delegate = self
                imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                imagePickerController.allowsEditing = false
                //self.presentViewController(imagePickerController, animated: true, completion: { imageP in })
            }
        }
    }
    
    func loadDataFromFirebase()
    {
        var listRef = Firebase(url: "https://amber-inferno-3172.firebaseio.com/pharmacists")
        listRef.observeEventType(.Value, withBlock: { snapshot in
            for id in snapshot.children.allObjects
            {
                self.pharmacists.addObject(id)
            }
            self.tableView.reloadData()
        });
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        myImage=image
        imagePickerController.dismissViewControllerAnimated(true, completion: {
            self.performSegueWithIdentifier("showPrescription", sender: self)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cameraButtonTouched(sender: AnyObject) {
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.pharmacists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        cell.textLabel!.text = self.pharmacists[indexPath.row].name
        var address = self.pharmacists[indexPath.row].childSnapshotForPath("address").value as String
        var distance = self.pharmacists[indexPath.row].childSnapshotForPath("distance").value as NSNumber
        var detail = String(format: "%@, %@km", address, distance)
        cell.detailTextLabel!.text = detail
        cell.detailTextLabel!.textColor = UIColor.whiteColor()
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.backgroundColor = UIColor.blackColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPrescription"
        {
            let prescriptionControl:PrescriptionController = segue.destinationViewController as PrescriptionController
            prescriptionControl.prescriptionImage = myImage
        }
    }
}