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
    func postCreated(text: String)
}

class ViewController: UIViewController {
    
    var logoPic: UIImageView!
    var tableView: UITableView!
    var postButton: UIImageView!
    var posts: [Post]!
    var chosenIndex: Int!
    var username: String!
    
    weak var delegate: ChangeViewControllerDelegate?
    
    let reuseIdentifier = "postCellReuse"
    let cellHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Posts"
        
        let p1 = Post(content: "When I was a kid I shot a metal dog bowl with a BB gun, it ricocheted into my dads sliding glass door. Bullet hole, spiderwebbed glass, I panicked. I picked up a piece of gravel, rubbed it into the bullet hole then placed the piece of gravel near the door. I then started up the lawnmower, mowed part of the back yard and intentionally mowed the grass too short. I told my dad I must have hit a rock while mowing. B.B. gun didn’t get taken away, which was great. But ten years later im an actual landscaper and my dad pays me to cut his grass. My stepmom makes me check for rocks before I mow, there aren’t ever any. It’s the lie that won’t go away.", user: "DrunkensAndDragons")
        let p2 = Post(content: "I had a mountain dew Baja blast addiction. In a single week a spent 50 bucks on the stuff. When I was quiting I had terrible headaches.", user: "LightBlade911")
        let p3 = Post(content: "I make a point to say hi to small animals like squirrels and birds, and help slow moving insects like snails traveling across sidewalks so they don’t get stepped on. But only when people won’t see me because I’m afraid they’ll make fun of me.I am in my late 30’s with a good job, family and mentally sound. I just love these lil critters.", user: "Swedish-Butt-Whistle")
        let p4 = Post(content: "Nobody in my family is aware I have made about 6 million from investments and my own businesses. They think I spend too much free time with inner city youth doing charity work for a low paying job. That job is my company.", user: "tiredofyourdrama")
        let p5 = Post(content: "I won the lottery the day after my 18th birthday. I won’t state how much, but I live in a state where you an claim anonymously. I haven’t told anyone and haven’t made any lifestyle changes. I do have a heck of a retirement fund and investment portfolio. The only reason I bring this up now is people are just starting to put the pieces together. Not sure if I will end up telling my family, but I can’t risk word getting out, as my sister has a huge mouth.", user: "Anonymoususer2345")
        let p6 = Post(content: "I would keep that secret and keep living a normal life. Secretly having financial independence must be a good feeling.", user: "bobasaurus")
        posts = [p1, p2, p3, p4, p5, p6]
        
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
        //username = text
        print(text)
    }
    
    func postCreated(text: String) {
        let pNew = Post(content: text, user: "changechangechangechangelater")
        posts.insert(pNew, at: 0)
        print(posts!)
        tableView.reloadData()
    }
}
