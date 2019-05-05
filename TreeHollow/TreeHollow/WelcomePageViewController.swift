//
//  WelcomePageViewController.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/25/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit
import GoogleSignIn

class WelcomePageViewController: UIViewController, GIDSignInUIDelegate {
    var imageView: UIImageView!
    var descriptionTextView: UILabel!
    var nameButton: UIButton!
    var GSButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        descriptionTextView = UILabel()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.text = "I‘m a tree hollow that collects secrets..."
        descriptionTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionTextView.backgroundColor = .white
        descriptionTextView.textAlignment = .center
        descriptionTextView.textColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        view.addSubview(descriptionTextView)
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        GSButton = GIDSignInButton()
        GSButton.translatesAutoresizingMaskIntoConstraints = false
        GSButton.colorScheme = .light
        GSButton.style = .wide
        view.addSubview(GSButton)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15 )
            ])
        
        NSLayoutConstraint.activate([
            GSButton.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 180),
            GSButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            GSButton.heightAnchor.constraint(equalToConstant: 40),
            GSButton.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
}
