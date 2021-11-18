//
//  MapViewDelegate.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
	
	///Roda quando a region do mapa mudou por algum motivo
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

	}
	
	func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
		
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//		guard let pin = view as? MKPointAnnotation else {return}
//		let editVC = EditPinViewController(with: pin)
//		present(editVC, animated: true)
	}
	
	func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
		
	}
	
}
