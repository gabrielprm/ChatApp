//
//  ViewController.swift
//  Mapp
//
//  Created by Gabriel do Prado Moreira on 17/11/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	private let mapView: MKMapView = {
		
		let map = MKMapView()
		
		map.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -15.77972, longitude: -47.92972), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
		
		map.isScrollEnabled = true
		map.isZoomEnabled = true
		
		return map
	}()
	
	let manager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Map"
		//manager.delegate = self
		
		view.addSubview(mapView)
		mapView.addMapConstraints(view)
		//mapView.delegate = self
	}

}

//MARK: - Manager Delegate
//extension MapViewController: CLLocationManagerDelegate {
//
//	///Permissão e autorização
//	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//		<#code#>
//	}
//
//	///Roda toda vez que muda a posição
//	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//		<#code#>
//	}
//
//	///Roda quando entra numa region
//	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//		<#code#>
//	}
//
//	///Roda quando sai de uma region
//	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//		<#code#>
//	}
//
//	///Quando começa a monitorar uma region
//	func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//		<#code#>
//	}
//
//}

//extension MapViewController: MKMapViewDelegate {
//
//	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//		<#code#>
//	}
//
//}
