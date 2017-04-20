//
//  LoginVC.swift
//  ClubsInstagram
//
//  Created by mahmoud khudairi on 4/14/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
class LoginVC: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var inAppLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 16, y: 570, width: view.frame.width - 40, height: 50)
        
        loginButton.addTarget(self, action: #selector(loginToAppUsingFacebook), for: .touchUpInside)
        
        
        
        //loginButton.delegate = self
  
      

    }
    
    func setupUI() {
        inAppLoginButton.layer.borderWidth = 1.0
        inAppLoginButton.layer.borderColor = UIColor.blue.cgColor
        
        signupButton.layer.borderWidth = 1.0
        signupButton.layer.borderColor = UIColor.gray.cgColor
    }
    
  

  
    
    
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                    
                self.goToFeedVC()
                
                }
            })
        }

    }

    @IBAction func SignUpButtonTapped(_ sender: Any) {
        let signupController = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
            present(signupController!, animated: true, completion: nil)
        
        
    }
    
    func goToFeedVC() {
        let feedController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        present(feedController!, animated: true, completion: nil)
        
    }
    
    
    func loginToAppUsingFacebook() {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                guard let fbloginresult : FBSDKLoginManagerLoginResult = result else { return }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result!)
                    
                }
            })
        }
    }
}
    
    


