

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SegmentTapped(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
                signInView.isHidden = false
                signUpView.isHidden = true
            
            }
            else{
                signInView.isHidden = true
                signUpView.isHidden = false
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


