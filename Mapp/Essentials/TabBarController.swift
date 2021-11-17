//
//  TabBarController.swift
//  Mapp
//
//  Created by Matheus Dantas on 17/11/21.
//

import UIKit

class TabBarController: UITabBarController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupChildren()
		tabBar.isTranslucent = false
		
    }
    
	func setupChildren() {
		
		let mapvc = MapViewController()
		let pinvc = PinViewController()
		let settingsvc = SettingsViewController()
		
		let mapNavVc = setUpNavigationController(image: UIImage(systemName: "map"), viewController: mapvc)
		let pinNavVc = setUpNavigationController(image: UIImage(systemName: "pin.circle"), viewController: pinvc)
		let settingsNavVc = setUpNavigationController(image: UIImage(systemName: "gearshape"), viewController: settingsvc)
		
		viewControllers = [mapNavVc, pinNavVc, settingsNavVc]
		
	}
	
	func setUpNavigationController(image: UIImage?, viewController: UIViewController) -> UINavigationController {

		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.tabBarItem.image = image
		navigationController.navigationBar.barTintColor = .blue
		return navigationController

	}
	
}
