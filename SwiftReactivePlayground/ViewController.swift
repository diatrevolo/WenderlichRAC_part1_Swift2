//
//  ViewController.swift
//  SwiftReactivePlayground
//
//  Created by Roberto Osorio Goenaga on 8/14/15.
//  http://www.raywenderlich.com/62699/reactivecocoa-tutorial-pt1
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var signInButton: UIButton?
    @IBOutlet weak var signInFailureText: UILabel?
    
    var passwordIsValid: Bool = false
    var usernameIsValid: Bool = false
    var signInService: RWDummySignInService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUIState()
        signInService = RWDummySignInService()
        
        userNameTextField?.addTarget(self, action: "usernameTextFieldChanged", forControlEvents: UIControlEvents.EditingChanged)
        passwordTextField?.addTarget(self, action: "passwordTextFieldChanged", forControlEvents: UIControlEvents.EditingChanged)
        
        signInFailureText?.hidden = true
    }
    
    func isValidUsername(username: String) -> Bool {
        return  username.characters.count > 3
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.characters.count > 3
    }
    
    @IBAction func signInButtonTouched(sender: AnyObject) {
        signInButton?.enabled = false
        signInFailureText?.hidden = true
        
        signInService?.signInWithUsername((userNameTextField?.text)!, password: (passwordTextField?.text)!, complete: { (success) -> Void in
            self.signInButton?.enabled = true
            self.signInFailureText?.hidden = success!
            if success! {
                self.performSegueWithIdentifier("signInSuccess", sender: self)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUIState() {
        userNameTextField?.backgroundColor = usernameIsValid ? UIColor.clearColor() : UIColor.yellowColor()
        passwordTextField?.backgroundColor = passwordIsValid ? UIColor.clearColor() : UIColor.yellowColor()
        signInButton?.enabled = usernameIsValid && passwordIsValid
    }
    
    func usernameTextFieldChanged() {
        self.usernameIsValid = isValidUsername((userNameTextField?.text)!)
        updateUIState()
    }
    
    func passwordTextFieldChanged() {
        self.passwordIsValid = isValidPassword((passwordTextField?.text)!)
        updateUIState()
    }

}

