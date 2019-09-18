
import UIKit

class SwipeViewController: UIViewController {
    //MARK: - Properties
    var chosenCategories: [String]!
    var arrOfBusinesses = [BusinessesWrapper]()
    var arrTuples = [(BusinessesWrapper, UIImage)]()
    var divisorNumber:CGFloat!
    var slideMenuDisplayed = false
    
    //MARK: - IBOutlets
    @IBOutlet var Category: UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var shadowViewTrailingContraints: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        divisorNumber = (view.frame.width / 2) / 0.61
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 5
        //createCardStack()
        // degree of tilt expressed in radian
        
        //gets businesses array
        let myGroup = DispatchGroup()
        fetchBusinesses(group: myGroup, arrCategories: chosenCategories)
        myGroup.notify(queue: DispatchQueue.main) {
            let images = self.arrOfBusinesses.compactMap{ business->UIImage? in
                guard let url = URL(string: business.image_url) else {return nil}
                guard let imageData = try? Data(contentsOf: url) else {return nil}
                return UIImage(data: imageData)
            }
            for index in 0..<self.arrOfBusinesses.count {
                self.arrTuples.append((self.arrOfBusinesses.reversed()[index], images[index]))
            }
            self.createCardStack()
        }
    }
    
    private func fetchBusinesses(group: DispatchGroup, arrCategories: [String]) {
        for category in arrCategories {
            group.enter()
            ResturantAPIClient.getbusinessesData(categorySearch: category) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let allbiz):
                        self.arrOfBusinesses += allbiz
                        group.leave()
                    case.failure(let error):
                        print(error)
                        group.leave()
                    }
                }
            }
        }
    }
    
    
    var imageView = UIImageView(image: UIImage(named: "fish"))
    
    private func createCardStack(){
        
        var newCard = UIView()
        arrTuples.forEach { (businessImagePairing) in
            let newGuesture = UIPanGestureRecognizer(target: self, action: #selector(panCardSwipe(_:)))
            newCard = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 450))
            newCard.layer.cornerRadius = 20
            newCard.layer.borderWidth = 3
            newCard.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            newCard.layer.shadowOpacity = 1
            newCard.layer.shadowRadius = 0.2
            newCard.center = self.view.center
            newCard.addGestureRecognizer(newGuesture)
            newCard.backgroundColor = .lightGray
            view.addSubview(newCard)
            
            imageView = UIImageView(image: businessImagePairing.1)
            print(businessImagePairing.0.image_url)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            newCard.addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: newCard.topAnchor, constant: 0.0),
                imageView.leadingAnchor.constraint(equalTo: newCard.leadingAnchor, constant: 0.0),
                imageView.trailingAnchor.constraint(equalTo: newCard.trailingAnchor, constant: 0.0)
                ])
            
        }
    }
    
    @IBAction func panCardSwipe(_ sender: UIPanGestureRecognizer) {
        guard let panCard = sender.view else {return}
        
        let fingerPoint = sender.translation(in: view)
        // line 25 allows us to know which direction the view is being dragged to. if the xFromCenter is positive then its to the right. if the xFromCenter is nagative then its to the left.
        let xFromCenter = panCard.center.x - view.center.x
        panCard.center = CGPoint(x: view.center.x + fingerPoint.x, y: view.center.y + fingerPoint.y)
        
        //value of rotationAngle must be converted to radian first
        panCard.transform = CGAffineTransform(rotationAngle: xFromCenter/divisorNumber)
        
        if xFromCenter > 0{
            panCard.layer.borderColor = #colorLiteral(red: 0.4923240542, green: 1, blue: 0.6202363372, alpha: 1)
//            likeDislikeImageView.image = UIImage(named: "thumbsDown")
//            likeDislikeImageView.tintColor = .red
        }else{
            panCard.layer.borderColor = #colorLiteral(red: 1, green: 0.2946998179, blue: 0.3782525361, alpha: 1)
//            likeDislikeImageView.image = UIImage(named: "thumbsDown")
//            likeDislikeImageView.tintColor = .red

        }
        
        
        if abs(xFromCenter)/view.center.x > 0{
          //  likeDislikeImageView.alpha = 0.5 + (abs(xFromCenter)/view.center.x)
        }
        
        if panCard.center.x > 257 || panCard.center.x < 157{
            panCard.alpha = 1 - (abs(xFromCenter)/view.center.x)
        }
        
        
        switch sender.state{
        case .changed:
            
            panCardChangedState(panCard)
        case .ended:            
            panCardReset(panCard)
        default:
            ()
        }
    }
    
    @IBAction func navigationMenuButtonPressed(_ sender: UIBarButtonItem) {
        
    
    }
    
    
    @IBAction func nextbuttonPressed(_ sender: UIButton) {
        
        guard let resturantVC = storyboard?.instantiateViewController(withIdentifier: "ResturantsViewController") as? ResturantsViewController else {return}
        self.navigationController?.pushViewController(resturantVC , animated: true)
    }
    
    private  func panCardChangedState(_ panCard:UIView){
        if panCard.center.x < (view.frame.width - 414){
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                panCard.center = CGPoint(x: panCard.center.x - 100, y: panCard.center.y )
                panCard.alpha = 0
                panCard.removeFromSuperview()
                
            })
            return
            
        }else if panCard.center.x > (view.frame.width){
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                panCard.center = CGPoint(x: panCard.center.x + 100, y: panCard.center.y )
                panCard.alpha = 1
                panCard.removeFromSuperview()
            })
        }
    }
    
    private func panCardReset(_ panCard:UIView){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            panCard.center = self.view.center
           // self.likeDislikeImageView.alpha = 0
            panCard.alpha = 1
            panCard.transform = CGAffineTransform.identity
            panCard.backgroundColor = .clear
        })
    }
    
    
    private  func printFunction(){
        print("main view \(view.center.x)")
        print("view.frame.width \(view.frame.width)")
       // print( "Like and dislike aplha" + "\(likeDislikeImageView.alpha)")
    }
    
    
    
}
