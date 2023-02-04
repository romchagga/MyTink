//
//  ViewController.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var finalNews: Array<FinalNews> = []
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let saved = CacheManager.shared.getNews(), !saved.isEmpty {
            print(saved)
            finalNews = saved
        } else {
            fetchData()
        }
        
        configViews()
        configurePullToRefresh()
    }
    
    private func configurePullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func configViews() {
        
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idCell)
    }
    
    func setConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func fetchData() {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let news):
                self?.finalNews = news
                CacheManager.shared.saveNews(news: self!.finalNews)
                self?.tableView.reloadData()
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finalNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCell, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        let news = finalNews[indexPath.row]
        cell.configViews(finalNews: news)
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.news = finalNews[indexPath.row]
        finalNews[indexPath.row].views += 1
        CacheManager.shared.saveNews(news: self.finalNews)
        tableView.reloadData()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

