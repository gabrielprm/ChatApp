//
//  RecognizerDelegate.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit

extension MapViewController: UIGestureRecognizerDelegate {
	
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
		return true
	}
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		return true
	}
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
		return true
	}
}
