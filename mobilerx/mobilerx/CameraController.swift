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
    
    var rxs: NSMutableArray = []
    var myImage: UIImage!
    var status :String!
    var nameFull : String!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !firstLaunch {
            firstLaunch=true
            loadDataFromFirebase()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            {
                var overlay = UIImage(named: "overlay.png")
                var overlayView = UIImageView(image: overlay)
                var vieww = UIView(frame: self.view.frame)
                vieww.addSubview(overlayView)
                imagePickerController.delegate = self
                imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                //imagePickerController.cameraOverlayView = vieww
                imagePickerController.allowsEditing = false
                //self.presentViewController(imagePickerController, animated: true, completion: { imageP in })
            }
        }
    }
    
    func loadDataFromFirebase()
    {
        var listRef = Firebase(url: "https://amber-inferno-3172.firebaseio.com/rx")
        listRef.observeEventType(.Value, withBlock: { snapshot in
            for id in snapshot.children.allObjects
            {
                self.rxs.addObject(id)
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
        return self.rxs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        var number = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("number").value as String
        
        var mass = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("mass").value as String
        
        var name = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("name").value as String
        
        status = self.rxs[indexPath.row].childSnapshotForPath("status").value as String

        cell.textLabel!.text = "\(number) x \(mass)mg \(name)"
        cell.textLabel!.font = UIFont(name: "Helvetica", size: 24)
        cell.detailTextLabel!.text = status
        cell.detailTextLabel!.textColor = UIColor.whiteColor()
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.backgroundColor = UIColor.blackColor()

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        var number = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("number").value as String
        
        var mass = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("mass").value as String
        
        var name = self.rxs[indexPath.row].childSnapshotForPath("drug").childSnapshotForPath("name").value as String
        
        status = self.rxs[indexPath.row].childSnapshotForPath("status").value as String
        nameFull = "\(number) x \(mass)mg \(name)"
        self.performSegueWithIdentifier("trackPers", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPrescription"
        {
            let prescriptionControl:PrescriptionController = segue.destinationViewController as PrescriptionController
            prescriptionControl.prescriptionImage = myImage
        }
        else if segue.identifier == "trackPers"
        {
            let trackControl : TrackController = segue.destinationViewController as TrackController
            
            trackControl.name = nameFull
            trackControl.status = status
        }
    }
    
    
    func showPrescriptionAdded() {
        var av = UIAlertView(title: "Prescription Submitted", message: "Your prescription was submitted, we'll notify you when it is ready.", delegate: self, cancelButtonTitle: "Ok")
        av.show()
    }
}