//
//  UploadVC.swift
//  ClubsInstagram
//
//  Created by mahmoud khudairi on 4/14/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit
import Firebase
class UploadVC: UIViewController {
    var userName = ""
    var userProfilePicture = ""
    @IBOutlet weak var UploadButton: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        handleImage()
    }
    func fetchUser() {
     
   
    }
    
    
    
    @IBAction func UploadButtonTapped(_ sender: Any) {
    
       
       
        
          //  guard let userUid = FIRAuth.auth()?.currentUser?.uid else {return}
        
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("postsImages").child("\(imageName).jpeg")
            
            let image = self.photoImageView.image
            guard let imageData = UIImageJPEGRepresentation(image!, 0.5) else { return }
            
            
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            storageRef.put(imageData, metadata: metaData, completion: { (metadata, error) in
                
                if error != nil {
                    print("Image error: \(error)")
                    return
                }
                
                if let pohtoImageUrl = metadata?.downloadURL()?.absoluteString,
                    let captionText = self.captionTextView.text {
                    guard let userUid = FIRAuth.auth()?.currentUser?.uid else {return}
                    FIRDatabase.database().reference().child("users").child(userUid).observe(.value, with: { (snapshot) in
                        
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            let user = User(dictionary: dictionary)
                            user.id = snapshot.key
                            guard let username = user.name,
                            let pic = user.profileImageUrl else{return}
                             self.userName = username
                             self.userProfilePicture = pic
                         
                        }
                        let values = ["caption": captionText, "userId": userUid, "postImageUrl": pohtoImageUrl,"userName":self.userName, "userProfileImageURL":self.userProfilePicture]
                        self.registerPostIntoDataBase(userUid, values: values as [String : AnyObject])
                        
                    }, withCancel: nil)
                   
                   
                }
                
            })
        
        self.tabBarController?.selectedIndex = 0

        
        
    }

    func registerPostIntoDataBase(_ uid: String, values: [String: Any]) {
        let ref = FIRDatabase.database().reference(fromURL: "https://clubsinstagram.firebaseio.com/")
        let PostsReference = ref.child("posts").childByAutoId()
        
        PostsReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print("Error saving user: \(err)")
                return
            }
            
            
            
        })
        
        
    }
    func handleImage(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(choosePostImage))
        photoImageView.isUserInteractionEnabled = true
       photoImageView.addGestureRecognizer(tap)
    }

    func choosePostImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
   

}
