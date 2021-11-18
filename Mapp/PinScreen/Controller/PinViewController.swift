//
//  PinViewController.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit

class PinViewController: UIViewController {

    var cdAnnotations = CoreDataManager.shared.fetchAllCDAnnotations()

    private var tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
    override func loadView() {
        super.loadView()
        
        //MARK: For testing remove later!
        if cdAnnotations.isEmpty {
            CoreDataManager.shared.createCDAnnotation(title: "Point 1", latitude: -15.79579, longitude: 48.04241)
            CoreDataManager.shared.createCDAnnotation(title: "Point 2", latitude: -15.79708, longitude: 48.05070)
            updateTableData()
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //updateTableData()
    }
    
    func updateTableData(){
        cdAnnotations = CoreDataManager.shared.fetchAllCDAnnotations()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func deleteAnnotation(indexPath: IndexPath){
        let cdAnnotation = cdAnnotations[indexPath.row]
        CoreDataManager.shared.deleteCDAnnotation(cdAnnotation: cdAnnotation)
        cdAnnotations.remove(at: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
    
    @objc func addNewPin(){
        let alert = UIAlertController(title: "Novo Alfinete", message: "Adicionar as coordenadas da latitude e longitude respectivamente", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = "Meu Alfinete"
            textField.placeholder = "Nome do Alfinete"
        }
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
            guard let titulo = alert?.textFields?[0].text,
                  let latitudeText = alert?.textFields?[1].text,
                  let longitudeText = alert?.textFields?[2].text
            else { return }
            guard let latitude = Double(latitudeText), let longitude = Double(longitudeText) else { return }
            
            CoreDataManager.shared.createCDAnnotation(title: titulo, latitude: latitude, longitude: longitude)
            self.updateTableData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: Table view delegate
extension PinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, complitionHandler in
            //complitionHandler(true)
            self.deleteAnnotation(indexPath: indexPath)
        }
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed cell at: \(indexPath.row)")
    }
}

//MARK: Table view data source
extension PinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdAnnotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = cdAnnotations[indexPath.row].title
        return cell
    }
}

extension PinViewController: UpdatableTable{
    func annotationCreated(newAnnotation: CDAnnotation) {
        cdAnnotations.append(newAnnotation)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
