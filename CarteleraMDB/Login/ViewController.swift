//
//  ViewController.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import UIKit
import Combine
import FirebaseAuthCombineSwift
import Firebase
class ViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel(apiClient: ApiClient())
    
    var cancellables = Set<AnyCancellable>()
    
    lazy var imagen: UIImageView = {
        let imagen = UIImageView()
        imagen.image = UIImage(named: "imagenTitle")
        imagen.translatesAutoresizingMaskIntoConstraints = false
        return imagen
    }()

    lazy var emailTextfield: UITextField = {
        let item = UITextField()
        item.placeholder = "Add Email"
        item.borderStyle = .roundedRect
        item.text = "adrian2@gmail.com"
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var passwordTextField: UITextField = {
        let item = UITextField()
        item.placeholder = "Add Password"
        item.text = "1234567890"
        item.borderStyle = .roundedRect
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    private lazy var loginButton: UIButton = {// importante colocar lazy para que permita declarar una accion
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.subtitle = "Bienvenido"
        configuration.image = UIImage(systemName: "play.circle.fill")
        configuration.imagePadding = 8
        
        let button = UIButton(type: .system , primaryAction: UIAction(handler: { action in
            self.startLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        createBindingViewWithModel() //Inicializamos los binding al entrar a la pantallas
        [imagen,emailTextfield,passwordTextField,loginButton,errorLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            imagen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            imagen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            imagen.bottomAnchor.constraint(equalTo: emailTextfield.topAnchor,constant: -20),
            
            emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextfield.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor,constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }

    func setGradientBackground() {
        let colorTop2 =  UIColor(red: 13.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 5.0).cgColor
        let colorTop =  UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 228.0/255.0, alpha: 5.0).cgColor
        let colorBottom = UIColor(red: 144.0/255.0, green: 206.0/255.0, blue: 161.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop2,colorTop, colorBottom]
        gradientLayer.locations = [0.1,0.5, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func startLogin() {
        loginViewModel.userLogin(withEmail: emailTextfield.text?.lowercased() ?? "", password: passwordTextField.text?.lowercased() ?? "")
    }
    
    func createBindingViewWithModel() {
        emailTextfield.textPublisher
            .assign(to: \LoginViewModel.email, on: loginViewModel)
            .store(in: &cancellables)
        passwordTextField.textPublisher
            .assign(to: \LoginViewModel.password, on: loginViewModel)
            .store(in: &cancellables)
        loginViewModel.$isEnable
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)
        loginViewModel.$showLoading
            .assign(to: \.configuration!.showsActivityIndicator, on: loginButton)
            .store(in: &cancellables)
        loginViewModel.$errorMessage
            .assign(to: \UILabel.text!, on: errorLabel)
            .store(in: &cancellables)
        loginViewModel.$userModel.sink { [weak self] succes in
            let movieListCombineView = MovieListCombineView()
            let navigationController = UINavigationController(rootViewController: movieListCombineView)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }.store(in: &cancellables)
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> { //Este publisher recopila solo valores tipo String y no retornara valores
        //En el return mandamos a llamar a NotificacionCenter para notificar que el textField ah reconocido una nueva interacion y agregamos un .map para obtener el text de la caja de texto
        return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { notification in
                return (notification.object as? UITextField)?.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}
