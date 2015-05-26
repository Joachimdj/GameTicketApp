 
import UIKit
import QuartzCore





class Login: UIViewController {
    
    //MARK: Outlets for UI Elements.
    @IBOutlet weak var usernameField:   UITextField!
    @IBOutlet weak var imageView:       UIImageView!
    @IBOutlet weak var passwordField:   UITextField!
    @IBOutlet weak var loginButton:     UIButton!
    @IBOutlet weak var facebookButton:     UIButton!
    @IBOutlet weak var visual: UIVisualEffectView!
    
    
    //MARK: Global Variables for Changing Image Functionality.
    private var idx: Int = 0
    private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg")]

    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        loginButton.alpha   = 0;
        facebookButton.alpha = 0;
         visual.alpha = 0.6
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 1.0
            self.facebookButton.alpha = 1.0
            }, completion: nil)
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        
        
        // SET first image
        imageView.image = UIImage(named: "img1.jpg")
       
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "changeImage", userInfo: nil, repeats: true)
        self.loginButton(false)
        
    }
    
    
    
    
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.greenColor()
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.greenColor()
                 self.facebookButton.backgroundColor = UIColor.blueColor()
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx++
        }
        var toImage = backGroundArray[idx];
        UIView.transitionWithView(self.imageView, duration: 3, options: .TransitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldDidChange() {
        if usernameField.text.isEmpty || passwordField.text.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
     
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBAction func close(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
        
    }
}
 





