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
    var prescriptionImage: UIImage!
    var pharmaName: String!
    var checkerPecker = false
    var state = -1
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.PharmacistLabel.text = pharmaName
    }
    
    func setPharmacistLabel(name: String)
    {
        self.pharmaName = name
    }
    
    @IBAction func closeTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showHome", sender: self)
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        
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