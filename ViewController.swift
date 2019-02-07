//
//  ViewController.swift
//  Pan
//
//  Created by Wolfgang Muhsal on 25.01.19.
//  Copyright © 2019 Wolfgang Muhsal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var stackviewTop: UIStackView!
    
    @IBOutlet weak var stackviewBottom: UIStackView!
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var panRecognizer: UIPanGestureRecognizer!
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    override func viewDidLoad() {
        
        
        button1.setImage(#imageLiteral(resourceName: "27075.png"), for: .normal)
        button2.setImage(#imageLiteral(resourceName: "37728.png"), for: .normal)
        button3.setImage( #imageLiteral(resourceName: "Berliner_Baer.svg.png")  , for: .normal)
        button4.setImage( #imageLiteral(resourceName: "Capture d’écran 2019-01-18 à 13.00.57.png") , for: .normal)
        stackviewTop.addArrangedSubview(button1)
        stackviewTop.addArrangedSubview(button2)
        stackviewBottom.addArrangedSubview(button3)
        stackviewBottom.addArrangedSubview(button4)
    }
    private var startView: UIView?
    private var dragView: UIView? {
        willSet {
            dragView?.removeFromSuperview()
        }
        didSet {
            guard let dragView = dragView else {
                return
            }
            dragView.isUserInteractionEnabled = false
            view.addSubview(dragView)
        }
    }

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //state("began")

            // Get view where interaction did start
            guard let touchView = analyze(recognizer: recognizer)
                
                else {
                return
            }

            // Remember the start view
        

            startView = touchView
            //print(startView)

            // Create a "copy" do move along the pan
            guard let dragView = touchView.snapshotView(afterScreenUpdates: false) else {
                // If creating a copy fails, let the gesture recognizer reset
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                return
            }
            dragView.alpha = 1
            // Put the copy right under the touch point
            dragView.center = recognizer.location(in: recognizer.view)

            // Save it for later
            self.dragView = dragView

        case .failed:
            //state("failed")

            startView = nil
            dragView = nil

        case .changed:
            //state("changed")

            // Put the copy right under the touch point
            dragView?.center = recognizer.location(in: recognizer.view)

        case .ended:
            // Forget the stored values when this case ends
            defer {
                startView = nil
                dragView = nil
            }

            guard let touchView = analyze(recognizer: recognizer),
                let startView = startView else {
                return
            }
            let startViewName = whichView(startView)
            let endViewName = whichView(touchView)
            
            inverseImage(startButton: startViewName, endButton: endViewName)
            
           

        default:
           // state("something strange happend")

            startView = nil
            dragView = nil

        }
    }

    func analyze(recognizer: UIPanGestureRecognizer) -> UIView? {
        let touchPoint = recognizer.location(in: recognizer.view)

        guard let recognizerAttachedToView = recognizer.view else {
            return nil
        }

        guard let hitView = recognizerAttachedToView.hitTest(touchPoint, with: nil) else {
            return nil
        }

        return hitView
    }

    func whichView(_ view: UIView) -> UIButton {
        switch view {
//        case backgroundView:
//            return "backgroundView"
//        case stackView:
//            return "stackView"
        case button1:
//            return "orangeView"
            return button1
        case button2:
//            return "blueView"
            return button2
        case button3:
            //            return "greenView"
            return button3
        case button4:
            //            return "greenView"
            return button4
        default:
//            return "other view"
            return button1
        }
    }

//    func state(_ text: String) {
//        statusLabel.text = text
//    }
    func inverseImage(startButton: UIButton,endButton: UIButton) {
    
        let buttonImage1 = whichView(startButton)
        let buttonImage2 = whichView(endButton)
        
        let imageFirst = buttonImage1.image(for: .normal)
        let imageSecond = buttonImage2.image(for: .normal)
        
        
        buttonImage2.setImage(imageFirst, for: .normal)
        buttonImage1.setImage(imageSecond, for: .normal)
    }
}
