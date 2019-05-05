//
//  ViewController.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/22/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit

protocol PostDelegate: class {
    func usernameCreated(text: String)
    func postCreated(text: String, nickname: String)
}

class ViewController: UIViewController {
    
    var logoPic: UIImageView!
    var tableView: UITableView!
    var postButton: UIImageView!
    var posts: [Posts]!
    var chosenIndex: Int!
    var username: String!
    
    weak var delegate: ChangeViewControllerDelegate?
    
    let reuseIdentifier = "postCellReuse"
    let cellHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Posts"
        
        posts = []
        
        logoPic = UIImageView()
        logoPic.translatesAutoresizingMaskIntoConstraints = false
        logoPic.image = UIImage(named: "logotext")
        logoPic.clipsToBounds = true
        logoPic.contentMode = .scaleAspectFit
        view.addSubview(logoPic)
        
        tableView = UITableView()
        tableView.estimatedRowHeight = cellHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        postButton = UIImageView()
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.image = UIImage(named: "plusicon")?.withRenderingMode(.alwaysTemplate)
        postButton.tintColor = UIColor(red: 104/255, green: 199/255, blue: 141/255, alpha: 1.0)
        postButton.clipsToBounds = true
        postButton.contentMode = .scaleAspectFit
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(postButtonPressed))
        postButton.addGestureRecognizer(tapGestureRecognizer)
        postButton.isUserInteractionEnabled = true
        view.addSubview(postButton)
        
        setupConstraints()
        getPosts()
}
    func getPosts(){
        NetworkManager.getPosts { (response) in
            self.posts = response.reversed()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            logoPic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoPic.heightAnchor.constraint(equalToConstant: 35),
            logoPic.widthAnchor.constraint(equalToConstant: 127.75)
            ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: logoPic.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
            ])
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant:10),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40),
            postButton.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    @objc func postButtonPressed(){
        print("post button pressed")
        let modalViewController = ModalPostViewController()
        modalViewController.delegate = self
        present(modalViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.configure(for: post)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}

extension ViewController: PostDelegate {
    func usernameCreated(text: String) {
    }
    
    func postCreated(text: String, nickname: String) {
        print("postCreated() is called")
        let pNew = Posts(id: 1000, text: text, nickname: nickname, uploaded: 52439859)
        posts.insert(pNew, at: 0)
        tableView.reloadData()
    }
}
