//
//  HomeVC.swift
//  EasyEvents
//
//  Created by RAKESH SOMANABOINA on 3/29/24.
//

import UIKit
import AnimatedGradientView

class HomeVC: UIViewController {

    
    
    
    
    
    @IBOutlet var homeimgCLCTN: [UIImageView]!
    
    
    
    
    
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
        
        let TapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        TapGestureRecognizer.numberOfTapsRequired = 1
        for img in homeimgCLCTN {
            img.isUserInteractionEnabled = true
            img.addGestureRecognizer(TapGestureRecognizer)
        }
        
        
        
      //  homeimgCLCTN.text = "Total Credits: \(totalCredits)"

        // Do any additional setup after loading the view.
    }
    
    @objc func handleTap(_: UITapGestureRecognizer){
        
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
