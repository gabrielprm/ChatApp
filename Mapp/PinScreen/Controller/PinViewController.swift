//
//  PinViewController.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit

class PinViewController: UIViewController {
    
    var alfinetes = [
        "Universidade Catolica de Brasilia",
        "Casa",
        "Shopping JK",
        "Aeroporto"
    ]

    private var tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, complitionHandler in
            complitionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed cell at: \(indexPath.row)")
    }
}

extension PinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alfinetes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = alfinetes[indexPath.row]
        return cell
    }
}
