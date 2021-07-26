//
//  TrackDescriptionViewController.swift
//  TableViewCode
//
//  Created by Алишер Батыр on 21.07.2021.
//

import UIKit
import SnapKit

class TrackDescriptionViewController: UIViewController {
    
    var singerName: String?
    var trackName: String?
    var imageURL: String?
    var countryLbl: String?
    var trackTimeMillisLbl: Int?
    var collectionPriceLbl: Double?
    var primaryGenreNameLbl: String?
  
    

    
    let options = ["Notifications", "Connected sevices", "About", "Logout"]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TrackDescriptionTableViewCell.self, forCellReuseIdentifier: TrackDescriptionTableViewCell.identifier)
        tableView.register(TrackHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerID")
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
        }

extension TrackDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  TrackDescriptionTableViewCell.identifier, for: indexPath) as!
            TrackDescriptionTableViewCell
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TrackHeaderView.headerID) as! TrackHeaderView
        header.singerName = singerName
        header.imageURL = imageURL
        header.trackName = trackName
        header.countryLbl = countryLbl
        header.trackTimeMillisLbl = trackTimeMillisLbl
        header.collectionPriceLbl = collectionPriceLbl
        header.primaryGenreNameLbl = primaryGenreNameLbl
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 450
    }

}
