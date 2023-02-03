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
    
    var news = [News]()
    let images = ["square.and.arrow.up", "square.and.arrow.up.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        
        fetchData()
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
    
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCell, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        let news = news[indexPath.row]
        cell.configViews(news: news)
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.news = news[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

