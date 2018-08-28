//
//  BucketListTableViewController.swift
//  BucketList
//
//  Created by John Tate on 8/23/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BucketListItemController.shared.bucketList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListCell", for: indexPath)

        let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
        cell.textLabel?.text = bucketListItem.title
        cell.detailTextLabel?.text = "\(bucketListItem.age)"

        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
            BucketListItemController.shared.delete(bucketListItem: bucketListItem)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. Check to make sure your segue is the right one from the storyboard using the segue identifier
        if segue.identifier == "toDetailVC" {
            // 2. Get the destination of the segue and cast it to your DetailVC Class
            let destinationVC = segue.destination as? DetailBucketListViewController
            
            // 3. Get the indexPath for whatever ro twht user selected
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // 4. Get your object from your source of truth by indexing it using the indexPath you just got in step 3.
            let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
            
            // 5. Create your landing pad in your detail VC Class
            // 6. Set your landing pad in your detailVC equal to the
            destinationVC?.bucketListItem = bucketListItem
            
            
        }
        
        
    }
    

}
