//
//  EditPinViewController.swift
//  Mapp
//
//  Created by Matheus Dantas on 18/11/21.
//

import UIKit
import MapKit

struct MapCoord {
	let latitude: Double
	let longitude: Double
}

protocol Locatable {
	var coordenada: MapCoord {get set}
	var titulo: String {get set}
	
}

extension MKPointAnnotation: Locatable {
	
	var coordenada: MapCoord {
		get {
			MapCoord(latitude: coordinate.latitude, longitude: coordinate.longitude)
		}
		set {
			coordinate.latitude = newValue.latitude
			coordinate.longitude = newValue.longitude
		}
	}
	
	var titulo: String {
		get {
			title ?? ""
		}
		set {
			title = newValue
			print(title)
		}
	}
	
	
}

class EditPinViewController: UIViewController {

	var pin: Locatable!
	var mapToUpdate: MKMapView!
    var updateTableDelegate: UpdatableTable?
    
	@IBOutlet weak var textField: UITextField!
    @IBOutlet weak var distanceTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		textField.becomeFirstResponder()
		
        setView()
    }
    
    private func setView(){
        guard let userLocation = CLLocationManager().location else {
            distanceTextLabel.isEnabled = false
            return
        }
        let pinLocation = CLLocation(latitude: pin.coordenada.latitude, longitude: pin.coordenada.longitude)
        let distance = userLocation.distance(from: pinLocation)
        let distanceString = distance < 1000 ? "\(Int(distance.rounded())) m" : String(format: "%.1f", distance/1000) + " km"
        distanceTextLabel.text = distanceString + " de distancia"
    }
    
	@IBAction func didPressDoneKey(_ sender: UITextField) {
		
		guard let text = sender.text else {return}
		print("öpa")
		CoreDataManager.shared.createCDAnnotation(title: text,
												  latitude: pin.coordenada.latitude,
												  longitude: pin.coordenada.longitude)
		pin.titulo = text
		print(pin.titulo)
        updateTableDelegate?.updateTable()
        
		dismiss(animated: true)
	}
}

