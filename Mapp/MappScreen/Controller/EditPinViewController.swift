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
			print(title!)
		}
	}
	
	
}

class EditPinViewController: UIViewController {

	var pin: Locatable!
    var updateTableDelegate: UpdatableTable?
    var isEditMode = false
    
	@IBOutlet weak var textField: UITextField!
    @IBOutlet weak var distanceTextLabel: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pinCoordinatesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		textField.text = pin.titulo
		setView()
		textField.becomeFirstResponder()
    }
    
    private func setView(){
        guard let userLocation = CLLocationManager().location else {
            distanceTextLabel.isEnabled = false
            return
        }
        let latitude = pin.coordenada.latitude
        let longitude = pin.coordenada.longitude
        
        let pinLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = userLocation.distance(from: pinLocation)
        let distanceString = distance < 1000 ? "\(Int(distance.rounded())) m" : String(format: "%.1f", distance/1000) + " km"
        distanceTextLabel.text = distanceString + " de distancia"
        
        addressView.layer.cornerRadius = 10
        
        CLGeocoder().reverseGeocodeLocation(pinLocation) { placemarks, error in
            if let error = error {
                print("Reverse Geocode Location Error: \(error)")
            }
            
            guard let placemark = placemarks?.first else { return }
            
            let name = placemark.name ?? ""
            let locality = placemark.locality ?? ""
            let subLocality = placemark.subLocality ?? ""
            let administrativeArea = placemark.administrativeArea ?? ""
            let postalCode = placemark.postalCode ?? ""
            let country = placemark.country ?? ""
            self.addressLabel.text = "\(name)\n\(subLocality)\n\(locality) - \(administrativeArea)\n\(postalCode)\n\(country)"
        }
        
        let latitudeText = String(format: "%.6f", latitude.magnitude) + "° " + (latitude > 0 ? "N" : "S")
        let longitudeText = String(format: "%.6f", longitude.magnitude) + "° " + (longitude > 0 ? "L" : "O")
        
        pinCoordinatesLabel.text = latitudeText + ", " + longitudeText
    }
    
	@IBAction func didPressDoneKey(_ sender: UITextField) {
		
		guard let text = sender.text else {return}

        if isEditMode{
            CoreDataManager.shared.saveContext()
        }
        else{
            CoreDataManager.shared.createCDAnnotation(title: text,
                                                      latitude: pin.coordenada.latitude,
                                                      longitude: pin.coordenada.longitude)
        }
		
		pin.titulo = text
        updateTableDelegate?.updateTable()
        
		dismiss(animated: true)
	}
}

