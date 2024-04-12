//
//  SignUpVC.swift
//  EasyEvents
//
//  Created by Jaswitha Reddy on 3/7/24.
//

import UIKit
import AVFoundation
import AnimatedGradientView
import Firebase

class SignUpVC: UIViewController {

    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var password: UILabel!
    
    @IBOutlet weak var confirmPwd: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var contactInfo: UILabel!
    
    @IBOutlet weak var createAcc: UIButton!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var passwordEnter: UITextField!
    
    @IBOutlet weak var confirmPsd: UITextField!
    
    @IBOutlet weak var validationMsgTV: UITextView!
    
    @IBOutlet weak var mobileNumberTF: UITextField!
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAcc.isEnabled = false
        self.passwordEnter.isEnabled = false
        self.confirmPsd.isEnabled = false
        self.firstName.isEnabled = false
        self.lastName.isEnabled = false
        self.contactInfo.isEnabled = false
        self.validationMsgTV.textColor = UIColor.red
       
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyEmail(_ sender: UITextField) {
        if(validateEmail(givenEmail: self.email.text)){
            self.validationMsgTV.text = ""
            self.passwordEnter.isEnabled = true
        }
    }
    
    @IBAction func verifyPassword(_ sender: UITextField) {
        if(validatePassword(givenPassword: self.passwordEnter.text)){
            self.validationMsgTV.text = ""
            self.confirmPsd.isEnabled = true
        }
    }
    
    @IBAction func verifyConfirmPassword(_ sender: UITextField) {
        if(self.passwordEnter.text == self.confirmPsd.text){
            self.validationMsgTV.text = ""
            self.firstName.isEnabled = true
            self.lastName.isEnabled = true
            self.contactInfo.isEnabled = true
        }else{
            self.validationMsgTV.text = "Confirm password doesnot match with Password"
        }
    }
    
    @IBAction func verifyMobileNumber(_ sender: UITextField) {
        if(validateMobileNumber(mobileNumber: self.mobileNumberTF.text)){
            self.createAcc.isEnabled = true
        }else{
            self.validationMsgTV.text = "Please enter a valid Mobile Number"
        }
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1103)
        guard let fName = self.firstNameTF.text, !fName.isEmpty else {
            self.validationMsgTV.text = "Please enter first name"
            return
        }
        guard let lName = self.lastNameTF.text, !lName.isEmpty else {
            self.validationMsgTV.text = "Please enter last name"
            return
        }
        self.validationMsgTV.text = ""
        // Assuming 'users' is the collection you want to create if it doesn't exist
        let usersCollectionName = "users"

         createCollectionIfNotExists(collectionName: usersCollectionName) { error in
            if let error = error {
                print("Error creating collection: \(error)")
            } else {
                print("Collection created or already exists: \(usersCollectionName)")
                let usersCollection = self.db.collection("users")

                // Assuming userData is a dictionary containing the user's data
//                let userId: String
//                let username: String
//                let password: String
//                let firstName: String
//                let lastName: String
//                let mobileNumber: String
                let userData: [String: Any] = [
                    "username": self.email.text!,
                    "password": self.passwordEnter.text!,
                    "firstName": self.firstNameTF.text!,
                    "lastName": self.lastNameTF.text!,
                    "mobileNumber": self.mobileNumberTF.text!
                ]

                // Add a new document with an auto-generated ID
                let docRef =  usersCollection.addDocument(data: userData) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added successfully")
                    }
                }
                
                let autoGeneratedDocumentID = docRef.documentID
                print("Auto-generated document ID: \(autoGeneratedDocumentID)")
            }
        }
        
        
        // logic to transfer on to main screen

    }
    
    func validateEmail(givenEmail :String?)-> Bool{
           guard let email = givenEmail, !email.isEmpty else {
               self.validationMsgTV.text = "Please enter the Email ID"
               self.validationMsgTV.textColor = UIColor.red
               return false}
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
              let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
           if(!emailPredicate.evaluate(with: email)){
               self.validationMsgTV.text = "Please enter a valid email ID"
                  return false
           }
           return true
       }
       
       func validatePassword(givenPassword: String?) -> Bool {
           guard let password = givenPassword , !password.isEmpty else {
                       self.validationMsgTV.text = "Please enter the password"
                       return false
                   }
           var messages: [String] = []
           messages.append("Password must contain at least")

           if !password.contains(where: { $0.isUppercase }) {
               messages.append("\n     • one capital letter")
           }
           
           if !password.contains(where: { $0.isNumber }) {
               messages.append("\n     • one digit.")
           }
           
           if !password.contains(where: { !$0.isLetter && !$0.isNumber }) {
               messages.append("\n     • special character.")
           }

           if password.count < 8 {
               messages.append("\n     • 8 characters long.")
           }
           
           if(messages.count > 1){
               self.validationMsgTV.text = messages.joined(separator: "")
               self.validationMsgTV.textColor = UIColor.red
               
               return false
           }

           return true
       }

    func validateMobileNumber(mobileNumber: String?) -> Bool {
        guard let num = mobileNumber, !num.isEmpty else {
            self.validationMsgTV.text = "Please enter the Mobile number"
            return false}
        print(num)
        let mobileRegex = #"^\d{10}$"#
        return NSPredicate(format: "SELF MATCHES %@", mobileRegex).evaluate(with: mobileNumber)
    }
    
    // Assuming Firebase has been configured already in your app delegate or elsewhere
    let db = Firestore.firestore()

    // Function to check if a collection exists
    func checkIfCollectionExists(collectionName: String, completion: @escaping (Bool) -> Void) {
        db.collection(collectionName).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                completion(false)
                return
            }
            completion(!snapshot.isEmpty)
        }
    }

    // Function to create a collection if it doesn't exist
    func createCollectionIfNotExists(collectionName: String, completion: @escaping (Error?) -> Void) {
        checkIfCollectionExists(collectionName: collectionName) { collectionExists in
            if !collectionExists {
                self.db.collection(collectionName).addDocument(data: [:]) { error in
                    completion(error)
                }
            } else {
                completion(nil)
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

}
