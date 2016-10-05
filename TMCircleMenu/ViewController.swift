//
//  ViewController.swift
//  TMCircleMenu
//
//  Created by Travis Ma on 8/1/16.
//  Copyright © 2016 Travis Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var constraintViewMenuTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintViewMenuTop: NSLayoutConstraint!
    @IBOutlet weak var constraintViewMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintViewMenuHeight: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    private var originCenter: CGPoint!
    private var menuSize: CGFloat = 0
    private var isFullScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            button.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        if menuSize == 0 {
            menuSize = menuView.frame.width
            originCenter = menuView.center
            menuView.layer.cornerRadius = menuView.frame.width / 2
            menuView.layer.masksToBounds = true
        }
    }
    
    @IBAction func btnMenuTap(_ sender: AnyObject) {
        self.view.isUserInteractionEnabled = false
        if isFullScreen {
            for button in buttons {
                button.isHidden = true
            }
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.menuView.transform = CGAffineTransform.identity
                self.menuView.center = self.originCenter
                }, completion: { completed in
                    self.view.isUserInteractionEnabled = true
                    self.btnMenu.setTitle("=", for: UIControlState())
            })
        } else {
            let scale = max((self.view.frame.height * 3) / menuSize, (self.view.frame.width * 3) / menuSize)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.menuView.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.menuView.center = self.view.center
                }, completion: { completed in
                    self.btnMenu.setTitle("x", for: UIControlState())
                    var duration: TimeInterval = 0.2
                    var counter = 0
                    for button in self.buttons {
                        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        button.isHidden = false
                        duration += 0.1
                        counter += 1
                        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                            button.transform = CGAffineTransform.identity
                            }, completion: { completed in
                                if counter == self.buttons.count {
                                    self.view.isUserInteractionEnabled = true
                                }
                        })
                    }
            })
        }
        isFullScreen = !isFullScreen
    }
}

