
import UIKit

class SwipeViewController: UIViewController {
    
    @IBOutlet var likeDislikeImageView: UIImageView!
    @IBOutlet var swipeCard: UIView!
    @IBOutlet var menuView: UIView!
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var slideViewMenuButtons: UIButton!
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var addAllButton: UIButton!
    
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var clearAll: UIButton!
    var divisorNumber:CGFloat!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet var homeButtonTopConstraints: NSLayoutConstraint!
    @IBOutlet var addAllButtonTopConstraints: NSLayoutConstraint!
    @IBOutlet var clearAllButtonTopConstraints: NSLayoutConstraint!
    @IBOutlet var reloadButtonTopConstraints: NSLayoutConstraint!
    
    @IBOutlet var shadowViewTrailingContraints: NSLayoutConstraint!
    @IBOutlet var menubarLeadindContraits: NSLayoutConstraint!
    var menuDisplayed = false
    var slideMenuDisplayed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // degree of tilt expressed in radian
        divisorNumber = (view.frame.width / 2) / 0.61
        swipeCard.layer.borderWidth = 3
        
        menubarLeadindContraits.constant = -250
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 5
        menuView.layer.cornerRadius = 20
        
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 5
        
        sliderMenuButtonInitialState()
    }
    
    func sliderMenuButtonInitialState(){
        homeButtonTopConstraints.constant = -40
        addAllButtonTopConstraints.constant = -40
        clearAllButtonTopConstraints.constant = -40
        reloadButtonTopConstraints.constant = -40
        
        homeButton.alpha = 0
        addAllButton.alpha = 0
        clearAll.alpha = 0
        reloadButton.alpha = 0
        
        homeButton.tintColor = .white
        addAllButton.tintColor = .white
        clearAll.tintColor = .white
        reloadButton.tintColor = .white
        slideViewMenuButtons.tintColor = .black
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
            self.navigationController?.navigationBar.backgroundColor = .clear
            self.swipeCard.backgroundColor = .clear
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
            panCard.backgroundColor = .green
            likeDislikeImageView.image = UIImage(named: "thumbsUp")
            likeDislikeImageView.tintColor = .green
            printFunction()
        }else{
            panCard.backgroundColor = .red
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
    
    @IBAction func navigationMenuButtonPressed(_ sender: UIBarButtonItem) {
        
        switch menuDisplayed{
        case false:
            // animates the menu view
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.menubarLeadindContraits.constant = -20
                
                self.view.layoutIfNeeded()
                
                self.menuDisplayed = true
            }) { (true) in
                self.menuButton.tintColor = .red
            }
            
            // animates the shadow view
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.shadowViewTrailingContraints.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
        case true:
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.menubarLeadindContraits.constant = -250
                self.view.layoutIfNeeded()
                self.slideViewMenuButtons.transform = CGAffineTransform.identity
                
                self.menuDisplayed = false
            }) { (true) in
                self.menuButton.tintColor = .black
            }
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.shadowViewTrailingContraints.constant = -414
                self.view.layoutIfNeeded()
            }, completion: nil)
            setupliderMenuButtons(Value: -40, bool: false, alpha: 0, Tranform: .identity, color: .white)
            slideViewMenuButtons.tintColor = .black
            
        }
    }
    
    @IBAction func slidweMenuButtonPressed(_ sender: UIButton) {
        
        switch slideMenuDisplayed{
        case false:
            setupliderMenuButtons(Value: 60, bool: true, alpha: 1, Tranform: .init(rotationAngle: (CGFloat(Double.pi / 2))), color: .blue)
      slideViewMenuButtons.tintColor = .red
        case true:
            setupliderMenuButtons(Value: -40, bool: false, alpha: 0, Tranform: .identity, color: .white)
     slideViewMenuButtons.tintColor = .black
        }
        
        
        
    }
    func setupliderMenuButtons(Value:CGFloat, bool:Bool, alpha:CGFloat, Tranform: CGAffineTransform, color:UIColor){
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.slideViewMenuButtons.transform = Tranform
            self.homeButtonTopConstraints.constant = Value
            self.addAllButtonTopConstraints.constant = Value
            self.clearAllButtonTopConstraints.constant = Value
            self.reloadButtonTopConstraints.constant = Value
            
            self.homeButton.alpha = alpha
            self.addAllButton.alpha = alpha
            self.clearAll.alpha = alpha
            self.reloadButton.alpha = alpha
            self.view.layoutIfNeeded()
        }, completion: { (true ) in
            self.homeButton.tintColor = color
            self.addAllButton.tintColor = color
            self.clearAll.tintColor = color
            self.reloadButton.tintColor = color
        })
        slideMenuDisplayed = bool
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func addAllButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func clearAllButtonPreesed(_ sender: UIButton) {
    }
    
    @IBAction func setButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextbuttonPressed(_ sender: UIButton) {
    }
}
