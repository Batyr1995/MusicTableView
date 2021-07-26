//
//  ViewController.swift
//  TableViewCode
//
//  Created by Алишер Батыр on 14.07.2021.
//

import UIKit

struct Music: Codable{
    var trackName: String
    var artistName: String
    var trackId: Int
    var artworkUrl100: String
    var country: String?
    var trackTimeMillis: Int?
    var collectionPrice: Double?
    var primaryGenreName: String?
    
}


struct MusicResponse: Codable {
    var resultCount: Int
    var results: [Music]
}

class ViewController: UIViewController{

    let tableView = UITableView()
    var data: MusicResponse?
    let urlString = "https://itunes.apple.com/search?term=i-think&entity=song"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            self?.getDataFromURL()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func getDataFromURL(){
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
    
        if let response = try? decoder.decode(MusicResponse.self, from: json) {
            data = response
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as! TrackTableViewCell
        cell.name = data?.results[indexPath.row].trackName
        cell.artist = data?.results[indexPath.row].artistName
        cell.id = data?.results[indexPath.row].trackId
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        data?.results.remove(at: indexPath.row)
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let trackVC = TrackDescriptionViewController()
                
        trackVC.singerName = data?.results[indexPath.row].artistName
        
        trackVC.trackName = data?.results[indexPath.row].trackName
        
        trackVC.imageURL = data?.results[indexPath.row].artworkUrl100
        
        trackVC.countryLbl = data?.results[indexPath.row].country

        trackVC.trackTimeMillisLbl = data?.results[indexPath.row].trackTimeMillis

        trackVC.collectionPriceLbl = data?.results[indexPath.row].collectionPrice
        
        trackVC.primaryGenreNameLbl = data?.results[indexPath.row].primaryGenreName

        navigationController?.pushViewController(trackVC, animated: true)
    }
}

