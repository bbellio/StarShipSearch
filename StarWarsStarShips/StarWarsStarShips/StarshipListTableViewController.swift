//
//  StarshipListTableViewController.swift
//  StarWarsStarShips
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class StarshipListTableViewController: UITableViewController {
    // MARK: - Variables
    var starships: [Starship] = [] {
           didSet {
               DispatchQueue.main.async {
                self.tableView.reloadData()
               }
           }
       }
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starshipCell", for: indexPath)
        let starship = starships[indexPath.row]
        cell.textLabel?.text = starship.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStarshipDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            guard let destinationVC = segue.destination as? StarShipDetailTableViewController else { return }
            let starshipToSend = starships[index.row]
            destinationVC.starship = starshipToSend
        }
    }
}

    // MARK: - Extension
extension StarshipListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        StarshipController.fetchStarshipsWith(searchText: searchText) { (starships) in
            self.starships = starships
        }
    }
}
