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
    
    let news = ["1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas1ajsdhajkshdakjshdakshdas", "asdkasjhdakjsdhaksjdhmnbxmznxbvkajhiquwyeiquyrjsdhfmnbvcmxncbvmxncvbkjshdfsdkhjfgqowieuqoiwueqoiwuekjahsdkjahsdnbxzcvmnxbcvmnxcbvkasjhdkajshdoqiuweyqowuey"]
    let images = ["square.and.arrow.up", "square.and.arrow.up.fill"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
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
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCell, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        cell.newsTitle.text = news[indexPath.row]
        cell.newsImage.image = UIImage(systemName: images[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

