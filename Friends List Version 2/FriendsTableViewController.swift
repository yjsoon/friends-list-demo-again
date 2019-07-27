//
//  FriendsTableViewController.swift
//  Friends List Version 2
//
//  Created by Soon Yin Jie on 6/7/19.
//  Copyright © 2019 Tinkercademy. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friendsArray: [Friend]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Check if there's data, if there is, load it, else, load sample
        if let loadedFriends = Friend.loadFromFile() {
            print("Loading existing friends")
            friendsArray = loadedFriends
        } else {
            print("Loading sample friends because I have none 😢")
            friendsArray = Friend.loadSampleData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)

        // Configure the cell...
        if let cell = cell as? FriendTableViewCell {
            let currentFriend = friendsArray[indexPath.row]
            cell.profileImageView.image = UIImage(named: currentFriend.imageFileName)
            cell.nameLabel.text = currentFriend.name
            cell.ageLabel.text = "\(currentFriend.age)"  // or String(currentFriend.age)
            cell.schoolLabel.text = currentFriend.school
        }
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            friendsArray.remove(at: indexPath.row)
            Friend.saveToFile(friends: friendsArray)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let friend = friendsArray.remove(at: fromIndexPath.row)
        friendsArray.insert(friend, at: to.row)
        Friend.saveToFile(friends: friendsArray)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFriend",
           let destVC = segue.destination as? DetailViewController,
           let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = friendsArray[indexPath.row]
            destVC.friend = friend
        }
    }

//    @IBAction func editButtonPressed(_ sender: Any) {
//        if tableView.isEditing {
//            tableView.setEditing(false, animated: true)
//            editButton.title = "Edit"
//        } else {
//            tableView.setEditing(true, animated: true)
//            editButton.title = "Done"
//        }
//    }
    
@IBAction func backToFriendsTable(with segue: UIStoryboardSegue) {
    if segue.identifier == "unwindSave",
       let sourceVC = segue.source as? EditFriendTableViewController
    {
        if sourceVC.needNewFriend {
            friendsArray.append(sourceVC.friend)
            Friend.saveToFile(friends: friendsArray)
        }
        tableView.reloadData()
    }
}
}
