//
//  ViewController.swift
//  Mapp
//
//  Created by Gabriel do Prado Moreira on 17/11/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	private let map: MKMapView = {
		let map = MKMapView()
				
		map.isScrollEnabled = true
		map.isZoomEnabled = true
		
		return map
	}()
	
	let manager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Map"
		
		//setando o mapa dentro da view
		view.addSubview(map)
		map.addMapConstraints(view)
		
		map.delegate = self
		
		//checar a as permissões de localização
		checkLocationEnabled()
	}
	
	func checkLocationEnabled() {
		if CLLocationManager.locationServicesEnabled() {
			setupLocationManager()
			checkAuthorizationStatus()
			
		}
		else {
			// alertar usuario que os serviços de localização do dispositivo tão desligados
		}
	}
	
	//seta o location manager
	func setupLocationManager() {
		manager.delegate = self
		
		//mais settings...
	}
	
	//renderiza um lugar no mapa
	func render(location: CLLocation) {
		
		let coordinate = location.coordinate
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		let region = MKCoordinateRegion(center: coordinate, span: span)
		
		map.setRegion(region, animated: true)
	
	}
	
	//checa o tipo autorização de acordo
	func checkAuthorizationStatus() {
		
		switch manager.authorizationStatus {
			
		case .authorizedWhenInUse, .authorizedAlways:
			// atualizar posiçao do user
			map.showsUserLocation = true
			render(location: manager.location!)
			manager.startUpdatingLocation()
			
		case .notDetermined:
			//pedir autorizaçao
			manager.requestWhenInUseAuthorization()
			
		case .denied:
			print("negado")
			
		case .restricted:
			print("restrito")
			
		@unknown default:
			print("não sabemos de nada")
		}
	}
	
}


//MARK: - Manager Delegate
extension MapViewController: CLLocationManagerDelegate {

	///Permissão mudou de estado
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkAuthorizationStatus()
	}

	///Roda toda vez que muda a posição
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard let location = locations.last else {return}
		
	}

	///Roda quando entra numa region
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		
	}

	///Roda quando sai de uma region
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		
	}

	///Quando começa a monitorar uma region
	func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
		
	}

}

extension MapViewController: MKMapViewDelegate {

	///Roda quando a region do mapa mudou por algum motivo
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		
	}

}
