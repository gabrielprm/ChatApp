//
//  PinViewController.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit

class PinViewController: UIViewController {
    

    private var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Alfinetes"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PinCell")
    }
}

extension PinViewController: UITableViewDelegate {
    
}

extension PinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell", for: indexPath)
        cell.textLabel?.text = "Hey"
        return cell
    }
}
