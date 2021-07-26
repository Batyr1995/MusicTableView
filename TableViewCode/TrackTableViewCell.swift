//
//  TrackTableViewCell.swift
//  TableViewCode
//
//  Created by Алишер Батыр on 21.07.2021.
//

import UIKit
import SnapKit

class TrackTableViewCell: UITableViewCell {

    static let identifier = "trackCell"
    
    var name: String? {
        didSet {
            trackNameLabel.text = name
        }
    }
    
    var artist: String? {
        didSet {
            trackArtistLabel.text = artist
        }
    }
    
    var id: Int? {
        didSet {
            trackIdLabel.text = "\(id ?? 0)"
        }
    }
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let trackArtistLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let trackIdLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(trackArtistLabel)
        contentView.addSubview(trackIdLabel)
    }
    
    func setupConstraints(){
        trackIdLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        trackNameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(15)
            make.width.equalTo(300)
        }
        trackArtistLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.width.equalTo(300)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

