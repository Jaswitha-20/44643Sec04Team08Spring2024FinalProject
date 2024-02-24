//
//  loginVC.swift
//  EasyEvents
//
//  Created by Divya Sarvepalli on 2/23/24.
//

import UIKit
import AnimatedGradientView
import AVFoundation

class loginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
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
    
    @IBAction func onLogin(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1103)
    }
    @IBAction func onSignUp(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1103)
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
