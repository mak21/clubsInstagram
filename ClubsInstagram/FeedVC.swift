//
//  FeedVC.swift
//  ClubsInstagram
//
//  Created by mahmoud khudairi on 4/14/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit
import Firebase
class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserIsLoggedIn()
    }

    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else
        {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                if let dictionary = snapshot.value as? [String: Any]
                {
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
            })
        }
        
    }
    
   
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
      
    }
    

    

}
