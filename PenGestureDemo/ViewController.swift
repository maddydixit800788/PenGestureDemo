//
//  ViewController.swift
//  PenGestureDemo
//
//  Created by Madhav on 15/09/19.
//  Copyright © 2019 Madhav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trashImage: UIImageView!
    
    @IBOutlet weak var fileViewImage: UIView!
    
    var fileViewOrigin: CGPoint!
    
    var fileViewSize: CGSize!
    
    var fileViewSmallSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileViewImage.layer.borderColor = UIColor.white.cgColor
        fileViewImage.layer.borderWidth = 1.0
        fileViewImage.layer.cornerRadius = 10
        fileViewImage.layer.masksToBounds = true
        
        fileViewOrigin = fileViewImage.frame.origin
        fileViewSize = fileViewImage.frame.size
        fileViewSmallSize = CGSize(width: 60.0, height: 60.0)
    }
  
    @IBAction func undoAction(_ sender: Any) {
        self.fileViewImage.frame.size = fileViewSize
        self.fileViewImage.frame.origin = self.fileViewOrigin
        UIView.animate(withDuration: 0.3) {
            self.fileViewImage.alpha = 1.0
        }
    }
    
    @IBAction func handleGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
            if(fileView.frame.intersects(trashImage.frame)) {
                UIView.animate(withDuration: 0.3) {
                    self.fileViewImage.alpha = 0.2
                    self.fileViewImage.frame.size = self.fileViewSmallSize
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.fileViewImage.alpha = 1.0
                    self.fileViewImage.frame.size = self.fileViewSize
                }
            }
        case .ended:
            if(fileView.frame.intersects(trashImage.frame)) {
                UIView.animate(withDuration: 0.3) {
                    self.fileViewImage.alpha = 0.0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.fileViewImage.frame.origin = self.fileViewOrigin
                }
            }
            break
        default:
            print("test")
        }
    }
}
