//
//  IntialVC.swift
//  EventManagementApplication
//
//  Created by RAKESH SOMANABOINA on 3/29/24.
//

import UIKit
import Lottie
import AnimatedGradientView

class IntialVC: UIViewController {
    
    @IBOutlet var ReceipeAnimation: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lottieView = LottieAnimationView(name: "event")
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit

        ReceipeAnimation.addSubview(lottieView)
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottieView.topAnchor.constraint(equalTo: ReceipeAnimation.topAnchor),
            lottieView.leadingAnchor.constraint(equalTo: ReceipeAnimation.leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: ReceipeAnimation.trailingAnchor),
            lottieView.bottomAnchor.constraint(equalTo: ReceipeAnimation.bottomAnchor)
        ])

        lottieView.play()
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let animationView = ReceipeAnimation.subviews.first as? LottieAnimationView {
            animationView.play()
        }
    }

}
