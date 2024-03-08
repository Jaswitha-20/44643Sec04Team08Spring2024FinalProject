//
//  SignUpVC.swift
//  EasyEvents
//
//  Created by Jaswitha Reddy on 3/7/24.
//

import UIKit
import AnimatedGradientView

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
        guard let fName = self.firstNameTF.text, !fName.isEmpty else {
            self.validationMsgTV.text = "Please enter first name"
            return
        }
        guard let lName = self.lastNameTF.text, !lName.isEmpty else {
            self.validationMsgTV.text = "Please enter last name"
            return
        }
        self.validationMsgTV.text = ""
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
