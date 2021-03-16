//
//  FeedViewController.swift
//  Parstagram
//
//  Created by John Smith V on 3/16/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    let myRefreshConrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        myRefreshConrol.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = myRefreshConrol
        // Do any additional setup after loading the view.
    }
    
    // When this table view appears we want to load in the last 20 posts...
    // We are loading in the stuff from the database
    @objc override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Querying the database
        let query =  PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        // Making sure that the posts are coming in descending order.... aka most recent
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshConrol.endRefreshing()
            }
        }
    }
    
    // When the user logs out
    @IBAction func onLogout(_ sender: Any) {
        // Want to logout of PF
        PFUser.logOut()
        // Want to go back to the login screen
        self.dismiss(animated: true, completion: nil)
        // Want to make sure to set the variable so the app knows that we need to login
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af.setImage(withURL: url)
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
