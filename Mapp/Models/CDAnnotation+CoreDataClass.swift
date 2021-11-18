//
//  CDAnnotation+CoreDataClass.swift
//  Mapp
//
//  Created by Pedro Ésli Vieira do Nascimento on 18/11/21.
//
//

import Foundation
import CoreData

@objc(CDAnnotation)
public class CDAnnotation: NSManagedObject, Locatable {
	
	var coordenada: MapCoord {
		get {
			MapCoord(latitude: latitude, longitude: longitude)
		}
		set {
			latitude = newValue.latitude
			longitude = newValue.longitude
		}
	}
	
	var titulo: String {
		get {
			title ?? ""
		}
		set {
			title = newValue
		}
	}
	

}
