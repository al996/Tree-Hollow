//
//  ModalPostViewController.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/25/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit

class ModalPostViewController: UIViewController {
    var descriptionText: UITextView!
    var dismissButton: UIButton!
    var textInput: UITextView!
    var confirmButton: UIButton!
    var warning: UILabel!
    
    var delegate: PostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Back", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.layer.cornerRadius = 12
        dismissButton.layer.masksToBounds = true
        dismissButton.backgroundColor = UIColor(red: 255/255, green: 172/255, blue: 7/255, alpha: 1.0)
        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight:.light)
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        descriptionText = UITextView()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.text = "What's your secret? "
        descriptionText.isEditable = false
        descriptionText.font = UIFont.systemFont(ofSize: 18, weight: .light)
        descriptionText.textColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        view.addSubview(descriptionText)
        
        textInput = UITextView()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.isEditable = true
        textInput.textColor = .black
        textInput.font = UIFont.systemFont(ofSize: 14)
        textInput.layer.borderColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0).cgColor
        textInput.layer.borderWidth = 1
        textInput.layer.cornerRadius = 16
        view.addSubview(textInput)
        
        warning = UILabel()
        warning.translatesAutoresizingMaskIntoConstraints = false
        warning.text = "You didn't type anything =( "
        warning.font = UIFont.systemFont(ofSize: 12, weight: .light)
        warning.backgroundColor = .white
        warning.numberOfLines = 0
        warning.textColor = .white
        view.addSubview(warning)
        
        confirmButton = UIButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("Tell the tree hollow", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 15
        confirmButton.layer.masksToBounds = true
        confirmButton.backgroundColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            dismissButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            dismissButton.heightAnchor.constraint(equalToConstant: 23),
            dismissButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            descriptionText.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 300),
            descriptionText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
            ])
        
        NSLayoutConstraint.activate([
            textInput.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 10),
            textInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            textInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            textInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -230)
            ])
        
        NSLayoutConstraint.activate([
            warning.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warning.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 30)
            ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant:50),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    @objc func dismissButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmButtonPressed(){
        if let newContent = textInput.text, newContent != ""{
            warning.textColor = .white
            print(newContent)
            delegate?.postCreated(text: newContent)
            NetworkManager.postSecrets(text: newContent, token: AppDelegate.usertoken)
//            NetworkManager.getPosts()
//            NetworkManager.getUser()
            dismiss(animated: true, completion: nil)
        }else{
            warning.textColor = .red
        }

    }
}
