//
//  UsernameViewController.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/25/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit

protocol ChangeViewControllerDelegate: class {
}


class UsernameViewController: UIViewController, UseridDelegate {
    var descriptionTextView: UILabel!
    var textInput: UITextField!
    var nameButton: UIButton!
    var warning: UILabel!
    
    var delegate: PostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        descriptionTextView = UILabel()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.text = "Please choose a nickname, as your secrets can remain anonymous =)"
        descriptionTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionTextView.backgroundColor = .white
        descriptionTextView.numberOfLines = 0
        descriptionTextView.textColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        view.addSubview(descriptionTextView)
        
        textInput = UITextField()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.textColor = .black
        textInput.font = UIFont.systemFont(ofSize: 14)
        textInput.borderStyle = .roundedRect
        view.addSubview(textInput)
        
        nameButton = UIButton()
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        nameButton.setTitle("Confirm! ", for: .normal)
        nameButton.setTitleColor(.white, for: .normal)
        nameButton.layer.cornerRadius = 15
        nameButton.layer.masksToBounds = true
        nameButton.backgroundColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        nameButton.addTarget(self, action: #selector(nameButtonPressed), for: .touchUpInside)
        view.addSubview(nameButton)
        
        warning = UILabel()
        warning.translatesAutoresizingMaskIntoConstraints = false
        warning.text = "You didn't type anything =( "
        warning.font = UIFont.systemFont(ofSize: 12, weight: .light)
        warning.backgroundColor = .white
        warning.numberOfLines = 0
        warning.textColor = .white
        view.addSubview(warning)
        
        //checkUser()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40 )
            ])
        
        NSLayoutConstraint.activate([
            textInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            textInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            textInput.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30 )
            ])

        NSLayoutConstraint.activate([
            warning.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warning.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 80)
            ])

        NSLayoutConstraint.activate([
            nameButton.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 108),
            nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameButton.heightAnchor.constraint(equalToConstant: 40),
            nameButton.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    @objc func nameButtonPressed(){
        print("confirm button pressed")
        if let username = textInput.text, username != ""{
            warning.textColor = .white
            print("username created")
            NetworkManager.registerUser(nickname: username, usertoken: AppDelegate.usertoken)
            
            let feedViewController = ViewController()
            feedViewController.delegate = self
            navigationController?.pushViewController(feedViewController, animated: true)
        }
        else{
            warning.textColor = .red
        }
        
    }
    
//    func checkUser(){
//        NetworkManager.getUser { (result) in
//            if result {
////                let feedViewController = ViewController()
////                feedViewController.delegate = self
////                navigationController?.pushViewController(feedViewController, animated: true)
//                print("getUser success")
//            }
//        }
//    }
}

extension UsernameViewController: ChangeViewControllerDelegate {
}

