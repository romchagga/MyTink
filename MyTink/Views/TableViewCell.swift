//
//  TableViewCell.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let idCell = "cell"
    
    var newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        return label
    }()
    
    var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var imageURL: URL? {
        didSet {
            newsImage.image = nil
            updateUI()
        }
    }
    
    var countsOfViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(8)
        return label
    }()
    
    var eyeImageForCount: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "eye"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
        countsOfViews.text = "1"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews(news: News) {
        newsTitle.text = news.title
        imageURL = URL(string: news.urlToImage ?? "https://www.clipartmax.com/png/full/417-4172781_the-bill-of-rights-is-a-part-of-the-constitution-news-clipart.png")
    }
    
    func updateUI() {
        if let url = imageURL {
            DispatchQueue.global(qos:.userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.newsImage.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
        
        func setConstraints() {
            self.addSubview(newsTitle)
            NSLayoutConstraint.activate([
                newsTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                newsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
                newsTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                newsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            ])
            
            self.addSubview(newsImage)
            NSLayoutConstraint.activate([
                newsImage.leadingAnchor.constraint(equalTo: newsTitle.trailingAnchor, constant: 8),
                newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
                newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                newsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
            ])
            
            self.addSubview(eyeImageForCount)
            NSLayoutConstraint.activate([
                eyeImageForCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                eyeImageForCount.widthAnchor.constraint(equalToConstant: 20),
                eyeImageForCount.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 4),
                eyeImageForCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            ])
            
            self.addSubview(countsOfViews)
            NSLayoutConstraint.activate([
                countsOfViews.leadingAnchor.constraint(equalTo: eyeImageForCount.trailingAnchor, constant: 8),
                countsOfViews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
                countsOfViews.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 4),
                countsOfViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            ])
            
        }
        
    }

