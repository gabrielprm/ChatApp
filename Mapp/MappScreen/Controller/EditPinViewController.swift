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
	
	@IBOutlet weak var textField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		textField.becomeFirstResponder()
		
    }
    
	@IBAction func didPressDoneKey(_ sender: UITextField) {
		
		guard let text = sender.text else {return}
		print("öpa")
		CoreDataManager.shared.createCDAnnotation(title: text,
												  latitude: pin.coordenada.latitude,
												  longitude: pin.coordenada.longitude)
		pin.titulo = text
		print(pin.titulo)
		
		dismiss(animated: true)
		
	}
}

