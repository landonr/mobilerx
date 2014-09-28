import UIKit

class PrescriptionController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    var prescriptionImage: UIImage!
    var pharmacists: NSMutableArray = []
    var selectedPharmacist: String!
    @IBOutlet var prescriptionView: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        prescriptionView.image = prescriptionImage
        self.tableView.delegate=self
        self.tableView.dataSource=self
        loadDataFromFirebase()
    }
    
    func setPrescriptionImage(image: UIImage) {
        prescriptionImage = image
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
        var dinosaurView = UIImage(named: "dino.png")
        var dinoView = UIImageView(image: dinosaurView)
        dinoView.frame = CGRect(x: 290, y: 10, width: 30, height: 30)
        var fax = self.pharmacists[indexPath.row].childSnapshotForPath("fax").value as NSNumber
        if fax == 1
        {
            cell.addSubview(dinoView)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        selectedPharmacist = cell!.textLabel!.text
        self.performSegueWithIdentifier("showConfirmation", sender: self)
    }
    
    func loadDataFromFirebase()
    {
        var listRef = Firebase(url: "https://amber-inferno-3172.firebaseio.com/pharmacists")
        listRef.observeEventType(.Value, withBlock: { snapshot in
            for id in snapshot.children.allObjects
            {
                println(id)
                self.pharmacists.addObject(id)
            }
            self.tableView.reloadData()
        });
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showConfirmation"
        {
            let confirmationControl:ConfirmationController = segue.destinationViewController as ConfirmationController
            confirmationControl.setPharmacistLabel(selectedPharmacist)
            confirmationControl.prescriptionImage = prescriptionImage
            //confirmationControl.pharmaId =
        }
    }
}