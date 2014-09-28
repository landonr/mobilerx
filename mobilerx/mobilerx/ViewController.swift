//
//  ViewController.swift
//  mobilerx
//
//  Created by Landon Rohatensky on 2014-09-27.
//  Copyright (c) 2014 Landon Rohatensky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var logoView: UIImageView!
    
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var blueView: UIImageView!
    @IBOutlet var welcomeView: UIImageView!
    @IBOutlet var getStartedView: UIView!
    @IBOutlet var readyButton: UIImageView!
    @IBOutlet var logoViewTwo: UIImageView!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var healthCardField: UITextField!
    
    var didAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !didAppear {
            var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("afterWelcome"), userInfo: nil, repeats: true)
            
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("moveBackgroundLeft"), userInfo: nil, repeats: true)
            UIView.animateWithDuration(30.0, animations: {
                self.backgroundView.frame.origin = CGPoint(x: 200, y: 0)
            });
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func afterWelcome()
    {
        if !didAppear {
            didAppear=true
            UIView.animateWithDuration(1.0, animations: {
                self.logoView.frame.origin = CGPoint(x: 127, y: 25)
                self.logoView.frame.size = CGSize(width: 121, height: 30)
                self.blueView.alpha = 0.8
                self.welcomeView.alpha = 0
            });
            var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("getStarted"), userInfo: nil, repeats: true)
        }
        else {
            self.logoView.frame.origin = CGPoint(x: 127, y: 25)
            self.logoView.frame.size = CGSize(width: 121, height: 30)
        }
    }
    
    func getStarted()
    {
        self.logoView.hidden=true
        self.logoViewTwo.hidden=false
        UIView.animateWithDuration(1.0, animations: {
            self.getStartedView.alpha = 1
        });

    }
    
    @IBAction func signinTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showSignIn", sender: self)

    }
    
    func moveBackgroundRight()
    {
        var timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("moveBackgroundLeft"), userInfo: nil, repeats: true)
        UIView.animateWithDuration(60.0, animations: {
            self.backgroundView.frame.origin = CGPoint(x: -200, y: 0)
        });
    }
    
    
    func moveBackgroundLeft()
    {
        var timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("moveBackgroundRight"), userInfo: nil, repeats: true)
        UIView.animateWithDuration(60.0, animations: {
            self.backgroundView.frame.origin = CGPoint(x: 200, y: 0)
        });
    }
    
    @IBOutlet var TapGestureOutlet: UITapGestureRecognizer!
    @IBAction func readyTapped(sender: AnyObject) {
        var patient = createPatient(firstNameField.text, lastNameField.text, healthCardField.text)
        fb.addPatient(patient)
        self.performSegueWithIdentifier("showCamera", sender: self)
    }
    
    @IBAction func healthValueChanged(sender: AnyObject) {
        var numberCount = countElements(self.healthCardField.text)
        if numberCount == 9{
            self.readyButton.userInteractionEnabled = true
            UIView.animateWithDuration(0.25, animations: {
                self.readyButton.alpha = 1
            });
        }
    }
   
}

