import UIKit

class SignInController: UIViewController
{
    
    @IBAction func signInTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showHome", sender: self)
    }
}