//
//  CLManagerDelegate.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit
import CoreLocation

extension MapViewController: CLLocationManagerDelegate {

	///Permissão mudou de estado
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkAuthorizationStatus()
	}

	///Roda sempre que atualiza a posição
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

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
