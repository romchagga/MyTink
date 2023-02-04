//
//  DetailViewController.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var news: FinalNews?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Title Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description label"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePublished: UILabel = {
        let label = UILabel()
        label.text = "DatePublished"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let author: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tapForWeb: UIButton = {
        let button = UIButton()
        button.setTitle("К источнику", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setViews()
        tapForWeb.addTarget(self, action: #selector(openWebPage) , for: .touchUpInside)
    }
    
    @objc func openWebPage() {
        let webPageViewController = WebPageViewController()
        webPageViewController.urlString = news?.url
        self.navigationController?.pushViewController(webPageViewController, animated: true)
    }
    
    func setViews() {
        view.backgroundColor = .white
        
        titleLabel.text = news?.title
        descriptionLabel.text = news?.description
        datePublished.text = news?.publishedAt?.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: " ")
        author.text = news?.author
        setImage()
    }
    
    func setImage() {
        guard let url = URL(string: news?.urlToImage ?? "https://www.clipartmax.com/png/full/417-4172781_the-bill-of-rights-is-a-part-of-the-constitution-news-clipart.png") else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }
        }
        
    }

    
    func setConstraints() {
        view.addSubview(newsImage)
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            newsImage.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 8),
        ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(author)
        NSLayoutConstraint.activate([
            author.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            author.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            author.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            author.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(datePublished)
        NSLayoutConstraint.activate([
            datePublished.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            datePublished.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            datePublished.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 8),
            datePublished.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tapForWeb)
        NSLayoutConstraint.activate([
            tapForWeb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tapForWeb.topAnchor.constraint(equalTo: datePublished.bottomAnchor, constant: 30),
            tapForWeb.widthAnchor.constraint(equalToConstant: 200),
            tapForWeb.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
