//
//  TrackHaederView.swift
//  Pods
//
//  Created by Алишер Батыр on 26.07.2021.
//

import UIKit
import SnapKit

class TrackHeaderView: UITableViewHeaderFooterView {
    
    static let headerID = "headerID"
    
    var trackName: String? {
        didSet {
            trackNameLabel.text = trackName
        }
    }
    
    var imageURL: String? {
        didSet {
            downloadImage(from: URL(string: imageURL ?? ""))
        }
    }
    
    var singerName: String? {
        didSet {
            singerNameLabel.text = singerName
        }
    }
    var countryLbl: String? {
        didSet {
            countryLabel.text = countryLbl
        }
    }
    var trackTimeMillisLbl: Int? {
        didSet {
            trackTimeMillisLabel.text = "\(trackTimeMillisLbl ?? 0)"
        }
    }
    var collectionPriceLbl: Double? {
        didSet {
            collectionPriceLabel.text = "\(collectionPriceLbl ?? 0)"
        }
    }
    var primaryGenreNameLbl: String? {
        didSet {
            primaryGenreNameLabel.text = primaryGenreNameLbl
        }
    }
    
    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let singerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var editButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Edit", for: .normal)
        button.layer.cornerRadius = 5
       return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 35
        return stackView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let trackTimeMillisLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
       return label
    }()
    
    private let collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let primaryGenreNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 35
        return stackView
    }()
    private let countryText: UILabel = {
        let label = UILabel()
        label.text = "COUNTRY"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let trackTimeText: UILabel = {
        let label = UILabel()
        label.text = "TRACK ID"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let priceText: UILabel = {
        let label = UILabel()
        label.text = "PRICE"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let genreText: UILabel = {
      let label = UILabel()
        label.text = "GENRE"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setupViews(){
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(trackImageView)
        contentView.addSubview(singerNameLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(stackView)
        [countryLabel, trackTimeMillisLabel, collectionPriceLabel, primaryGenreNameLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(secondStackView)
        [countryText, trackTimeText, priceText, genreText].forEach{
            secondStackView.addArrangedSubview($0)
        }
    }
    
    
    func downloadImage(from url: URL?) {
            guard let url = url else { return }
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async { [weak self] in
                    self?.trackImageView.image = UIImage(data: data)
                }
            }
        }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

    
    func setupConstraints(){
        trackImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.size.equalTo(100)
        }
        trackNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackImageView.snp.bottom).offset(20)
            make.right.left.equalToSuperview().inset(20)
        }
        singerNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackNameLabel.snp.bottom).offset(20)
        }
        editButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(singerNameLabel.snp.bottom).offset(40)
            make.width.equalTo(60)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(editButton.snp.bottom).offset(50)
            make.right.left.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        secondStackView.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.right.left.equalToSuperview().inset(20)
        }
    }
}
