import UIKit

class LoginViewController: UIViewController {
    
    var secondVC = EmailSignUpViewController()
    let userEmail:String = "aabudu16@yahoo.com"
    let userPassword:String = "Abu123"
    @IBOutlet var pursuitLogo: UIImageView!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var singupButton: UIButton!
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var loginButtonView: UIView!
    @IBOutlet var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupEmailView()
        setupPasswordView()
        setupLoginButtonView()
    }
    
    private func configureView(){
        loginButton.layer.cornerRadius = 25
        loginButton.setTitleColor(.black, for: .highlighted)
    
        
    }
    private func setupEmailView(){
        emailView.layer.shadowColor = UIColor.black.cgColor
        emailView.layer.shadowOpacity = 1
        emailView.layer.shadowOffset = .zero
        emailView.layer.shadowRadius = 10
    }
    
    private func setupPasswordView(){
        passwordView.layer.shadowColor = UIColor.black.cgColor
        passwordView.layer.shadowOpacity = 1
        passwordView.layer.shadowOffset = .zero
        passwordView.layer.shadowRadius = 10
    }
    
    private func setupLoginButtonView(){
        loginButtonView.layer.shadowColor = UIColor.black.cgColor
        loginButtonView.layer.shadowOpacity = 1
        loginButtonView.layer.shadowOffset = .zero
        loginButtonView.layer.shadowRadius = 10
    }
    @IBAction func buttomPressed(_ sender: UIButton) {
        
        switch sender.tag{
        case 0:
            if emailTextField.text != userEmail || passwordTextField.text != userPassword{
                errorMessageLabel.text = "Invalid Email or Password"
                errorMessageLabel.alpha = 1
            }else{
               errorMessageLabel.text = "Welcome Back"
                errorMessageLabel.alpha = 1
            }
            print("Login Test")
        case 1:
            guard let emailString = emailTextField.text else {
                return
            }
            let vc = EmailSignUpViewController(nibName: "EmailSignUpViewController", bundle: nil)
          // vc.emailTextField.text = emailString
            print("signup Test")
        default:
            return
        }
    }
}


