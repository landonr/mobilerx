import UIKit

class ConfirmationController: UIViewController
{
    
    @IBOutlet var immediatelyChecker: UIImageView!
    @IBOutlet var todayChecker: UIImageView!
    @IBOutlet var weekChecker: UIImageView!
    @IBOutlet var deliveryChecker: UIImageView!
    @IBOutlet var closeButton: UIImageView!
    @IBOutlet var PharmacistLabel: UILabel!
    @IBOutlet var submitOrderLabel: UILabel!
    @IBOutlet var networkLayer: UIView!
    
    var prescriptionImage: UIImage!
    var pharmaName: String!
    var pharmaId : String!
    var checkerPecker = false
    var state = -1
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.PharmacistLabel.text = pharmaName
        networkLayer.hidden = true
    }
    
    func setPharmacistLabel(name: String)
    {
        self.pharmaName = name
    }
    
    @IBAction func closeTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showHome", sender: self)
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        var imageData : NSData = UIImageJPEGRepresentation(prescriptionImage, 0.6)
        var i: String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        var work = createWorkOrder(patientId, "123", i, pharmaName)
        
        var ind = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
        
        ind.center = self.view.center
        ind.hidesWhenStopped = true
        ind.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.view.addSubview(ind)
        ind.startAnimating()
        UIView.animateWithDuration(0.5, animations: {
            self.networkLayer.alpha = 0.65
        });
        networkLayer.hidden = false
        fb.postWorkOrder(work, { ()->Void in
            ind.stopAnimating()
            self.networkLayer.alpha = 0
            self.networkLayer.hidden = true
            self.performSegueWithIdentifier("showHome", sender: self)
        })
    }
    
    @IBAction func immediatelyTapped2(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 1
        immediatelyChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }
    
    @IBAction func immediatelyTapped(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 1
        immediatelyChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }

    @IBAction func todayTapped2(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 2
        todayChecker.image = UIImage(named:"check.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }
    
    @IBAction func todayTapped(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 2
        todayChecker.image = UIImage(named:"check.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }
    @IBAction func deliveryTapped2(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 3
        deliveryChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
    }
    @IBAction func deliveryTapped(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 3
        deliveryChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        weekChecker.image = UIImage(named:"nocheck.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
    }
    @IBAction func weekTapped2(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 4
        weekChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }
    @IBAction func weekTapped(sender: AnyObject) {
        if !self.checkerPecker{
            self.checkerPecker = true
            UIView.animateWithDuration(0.4, animations: {
                self.submitOrderLabel.alpha=1
            });
        }
        self.state = 4
        weekChecker.image = UIImage(named:"check.png")
        todayChecker.image = UIImage(named:"nocheck.png")
        immediatelyChecker.image = UIImage(named:"nocheck.png")
        deliveryChecker.image = UIImage(named:"nocheck.png")
    }
}