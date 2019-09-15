//
//  SwipeViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/14/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    @IBOutlet var likeDislikeImageView: UIImageView!
    @IBOutlet var swipeCard: UIView!
    var divisorNumber:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        // degree of tilt expressed in radian
        divisorNumber = (view.frame.width / 2) / 0.61
        swipeCard.layer.borderWidth = 3
    }
    func printFunction(){
        print("main view \(view.center.x)")
        print("panCard \(swipeCard.center.x)")
        print("view.frame.width \(view.frame.width)")
        print( "Like and dislike aplha" + "\(likeDislikeImageView.alpha)")
    }
    func resetPanCard(){
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeCard.center = self.view.center
            self.likeDislikeImageView.alpha = 0
            self.swipeCard.alpha = 1
            self.swipeCard.transform = CGAffineTransform.identity
        })
        
    }
    @IBAction func panCardSwipe(_ sender: UIPanGestureRecognizer) {
        let panCard = sender.view!
        let fingerPoint = sender.translation(in: view)
        // line 25 allows us to know which direction the view is being dragged to. if the xFromCenter is positive then its to the right. if the xFromCenter is nagative then its to the left.
        let xFromCenter = panCard.center.x - view.center.x
        panCard.center = CGPoint(x: view.center.x + fingerPoint.x, y: view.center.y + fingerPoint.y)
        
        //value of rotationAngle must be converted to radian first
        panCard.transform = CGAffineTransform(rotationAngle: xFromCenter/divisorNumber)
        
        if xFromCenter > 0{
            likeDislikeImageView.image = UIImage(named: "thumbsUp")
            likeDislikeImageView.tintColor = .green
            printFunction()
        }else{
            likeDislikeImageView.image = UIImage(named: "thumbsDown")
            likeDislikeImageView.tintColor = .red
            printFunction()
        }
   
        
            if abs(xFromCenter)/view.center.x > 0{
            //panCard.alpha = 1 - (abs(xFromCenter)/view.center.x)
                likeDislikeImageView.alpha = 0.5 + (abs(xFromCenter)/view.center.x)
            }
        
        if panCard.center.x > 257 || panCard.center.x < 157{
            panCard.alpha = 1 - (abs(xFromCenter)/view.center.x)
           // likeDislikeImageView.alpha = 0.7 + (abs(xFromCenter)/view.center.x)
            
        }
        
        //recenter the view when finger is off
        if sender.state == UIGestureRecognizer.State.ended{
            //one
            if panCard.center.x < 75{
                UIView.animate(withDuration: 2, animations: {
                    panCard.center = CGPoint(x: panCard.center.x - 400, y: panCard.center.y + 100)
                    panCard.alpha = 0
                    
                })
                return
                // or two
            }else if panCard.center.x > (view.frame.width){
                UIView.animate(withDuration: 0.3, animations: {
                    panCard.center = CGPoint(x: panCard.center.x + 100, y: panCard.center.y )
                  panCard.alpha = 1
                    
                })
                return
            }
            resetPanCard()
        }
        
    }
    
    
}
