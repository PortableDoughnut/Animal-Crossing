//
//  VillagerTableViewController.swift
//  Animal Crossing
//
//  Created by Gwen Thelin on 11/25/24.
//

import UIKit

class VillagerTableViewController: UITableViewController {

	var villagers: [Villager] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		fetchVillagers {
			DispatchQueue.main.async {
				print("reloading data with \(self.villagers.count) villagers")
				self.tableView.reloadData()
			}
		}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return villagers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell =
				tableView.dequeueReusableCell(withIdentifier: "VillagerCell", for: indexPath) as? VillagerTableViewCell
		else { return UITableViewCell() }

        // Configure the cell...
		cell.configure(with: villagers[indexPath.row])

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
	
	func fetchVillagers(completion: @escaping () -> Void) {
		var villagerURLComponents: URLComponents = .init()
		
		villagerURLComponents.scheme = "https"
		villagerURLComponents.host = "api.nookipedia.com"
		villagerURLComponents.path = "/villagers"
		
		guard let url = villagerURLComponents.url else {
			print("Error: Could not contstruct URL from URLComponents")
			return
		}
		
		var request: URLRequest = .init(url: url)
		request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
		
		Task {
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
					print("Error: Bad HTTP response")
					return
				}
				
				villagers = try JSONDecoder().decode([Villager].self, from: data)
				
				for villager in villagers {
					print("\(villager.name)")
				}
				completion()
			} catch {
				print("Error: \(error.localizedDescription)")
				return
			}
		}
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
