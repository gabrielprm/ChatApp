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
    
    override func loadView() {
        super.loadView()
     
    }
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPin))
    }
    
    @objc func addNewPin(){
        let alert = UIAlertController(title: "Novo Alfinete", message: "Adicionar as coordenadas da latitude e longitude respectivamente", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = "20.2345"
            textField.placeholder = "Latitude"
        }
        alert.addTextField { textField in
            textField.text = "-12.4453"
            textField.placeholder = "Longitude"
        }
        
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: { [weak alert] _ in
            //Salvar as coordenadas
            guard let latitude = alert?.textFields?[0].text, let longitude = alert?.textFields?[1].text else {
                return
            }
            
            print("\(latitude) \(longitude)")
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
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
