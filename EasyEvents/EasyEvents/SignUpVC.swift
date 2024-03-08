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
        // Do any additional setup after loading the view.
    }
    @IBAction func createAccount(_ sender: UIButton) {
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
