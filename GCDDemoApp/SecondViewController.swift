//
//  SecondViewController.swift
//  GCDDemoApp
//
//  Created by admin on 28.07.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageURL: URL?
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3, closure: loginAlert)
    }
    
    private func delay(_ delay: Int, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    private func loginAlert(){
        let controller = UIAlertController(title: "Зарегистрированы?", message: "Введите данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        controller.addTextField { textField in
            textField.placeholder = "Введите логин"
        }
        controller.addTextField { textField in
            textField.placeholder = "Введите пароль"
            textField.isSecureTextEntry = true
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    private func fetchImage(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.imageURL = URL(string: "https://klike.net/uploads/posts/2019-05/1556708032_1.jpg")
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
