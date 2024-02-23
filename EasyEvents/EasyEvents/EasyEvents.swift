//
//  EasyEvents.swift
//  EasyEvents
//
//  Created by Kalikiri,Jaswitha on 2/21/24.
//

import UIKit
import Lottie
import AnimatedGradientView
import AVFoundation

class EasyEvents: UIViewController {
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
            LaunchLAV.animation = LottieAnimation.named("event")
            LaunchLAV.alpha = 1
            LaunchLAV.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                    self?.LaunchLAV.alpha = 0.0
                }
            }
        }
    }
    
    @IBOutlet weak var WelcomeTV: UITextView!
    
    @IBAction func getStartWelcome(_ sender: UIButton) {
        // logic to navigate to login page
        AudioServicesPlaySystemSound(1103)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WelcomeTV.text = "Every Event is Made Easy through Easy Events"
        self.WelcomeTV.layer.borderColor = UIColor.black.cgColor
        self.WelcomeTV.layer.borderWidth = 5.0
        self.WelcomeTV.layer.cornerRadius = 5.0
        
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//#Preview("EasyEvents"){
//    UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//}
