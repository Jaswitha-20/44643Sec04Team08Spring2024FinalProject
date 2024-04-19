//
//  SettingVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/10/24.
//

import UIKit
import AnimatedGradientView

class SettingVC: BaseViewController {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
        self.getProfileData()
    }
    
    
    func getProfileData(){
        FireStoreManager.shared.dbRef.document(UserDefaultsManager.shared.getDocumentId()).getDocument { (document, error) in
            if let error = error {
                
            } else {
                if let document = document, document.exists {
                    if let data = document.data() {
                        self.firstname.text = data["firstname"] as? String ?? ""
                        self.phone.text = data["phone"] as? String ?? ""
                        self.lastName.text = data["lastname"] as? String ?? ""
                        self.email.text = data["email"] as? String ?? ""
                        self.password = data["password"] as? String ?? ""
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        UserDefaultsManager.shared.clearUserDefaults()
        UserDefaults.standard.removeObject(forKey: "documentId")
        SceneDelegate.shared!.loginCheckOrRestart()
    }

    @IBAction func onUpdate(_ sender: UIButton) {
            let documentid = UserDefaultsManager.shared.getDocumentId()
        let userData = UserRegistrationModel(firstname: self.firstname?.text, lastname: self.lastName?.text, email: self.email?.text, phone: self.phone?.text, password: self.password)
        FireStoreManager.shared.updateProfile(documentID: documentid, user: userData) { success in
                if success {
                    globalAlart(message: "Profile Updated Successfully")
                }
            }
        
    }
    
//    @IBAction func onEdit(_ sender: Any) {
//        if !editBool {
//            self.editBtn.setTitle("Save", for: .normal)
//            self.userInteractionTrue()
//            editBool = true
//        } else {
//            if validate(){
//                let documentid = UserDefaultsManager.shared.getDocumentId()
//
//                let userData = UserRegistrationModel(name: self.name.text?.lowercased() ?? "", email: self.userData?.email, dob: self.dob.text ?? "", phone: self.phone.text ?? "", password: self.userData?.password, userType: self.userType.text ?? "", barId: self.barId.text ?? "")
//
//                FireStoreManager.shared.updateProfile(documentid: documentid, user: userData) { success in
//                    if success {
//                        showAlerOnTop(message: "Profile Updated Successfully")
//                    }
//                }
//                editBool = false
//                self.editBtn.setTitle("Edit Profile Details", for: .normal)
//                self.userInteractionFalse()
//            }
//        }
//    }
    
 
//    func validate() ->Bool {
//
//        if(self.name.text!.isEmpty) {
//             showAlerOnTop(message: "Please enter name.")
//            return false
//        }
//
//        if(self.phone.text!.isEmpty) {
//             showAlerOnTop(message: "Please enter phone.")
//            return false
//        }
//
//        if(self.dob.text!.isEmpty) {
//            showAlerOnTop(message: "Please enter dob.")
//           return false
//       }
//
//        if(self.userType.text!.isEmpty) {
//             showAlerOnTop(message: "Please enter user type.")
//            return false
//        }
//
//        if(self.barId.text!.isEmpty) {
//             showAlerOnTop(message: "Please enter bar id.")
//            return false
//        }
////        if !isValidCode(self.barId.text ?? ""){
////            showAlerOnTop(message: "Please enter valid bar id.")
////           return false
////        }
//        return true
//    }
}
