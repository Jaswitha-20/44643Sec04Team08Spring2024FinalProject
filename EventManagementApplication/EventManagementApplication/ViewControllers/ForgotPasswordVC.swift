//
//  ForgotPasswordVC.swift
//  EventManagementApplication
//
//  Created by RAKESH SOMANABOINA on 3/29/24.
//

import UIKit
import AnimatedGradientView

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var email: UITextField!

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
    }
    
    @IBAction func onSend(_ sender: Any) {
        if(email.text!.isEmpty) {
            globalAlart(message: "Please enter your email id.")
            return
        }
        else{
            FireStoreManager.shared.getPassword(email: self.email.text!.lowercased(), password: "") { password in
                print(password)
            }
        }
    }


}
