//
//  StarShipDetailTableViewController.swift
//  StarWarsStarShips
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class StarShipDetailTableViewController: UITableViewController {
    // MARK: - Global Variables
    var films: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Receiver
    var starship: Starship? {
        didSet {
            self.loadViewIfNeeded()
            guard let starship = starship else { return }
            for film in starship.films {
                StarshipController.getFilm(filmURL: film) { (film) in
                    guard let film = film else { return }
                    let title = film.title
                    self.films.append(title)
                }
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    // MARK: - Functions
    func updateViews() {
        guard let starship = starship else { return }
        title = starship.name
        nameLabel.text = starship.name
        modelLabel.text = starship.model
        costLabel.text = starship.cost
        speedLabel.text = starship.speed
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)
        let filmTitle = films[indexPath.row]
        cell.textLabel?.text = filmTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movies"
    }
}
