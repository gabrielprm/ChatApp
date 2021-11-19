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
    }
    
	func setupChildren() {
        let mapViewController = MapViewController()
        let pinViewController = PinViewController()
        
        mapViewController.updateTableDelegate = pinViewController
		
		//cria view controllers que serão apresentadas pela tab bar controller
		let mapNavVc = setUpNavigationController(image: UIImage(systemName: "map"), viewController: mapViewController)
		let pinNavVc = setUpNavigationController(image: UIImage(systemName: "pin.circle"), viewController: pinViewController)
        pinNavVc.navigationBar.prefersLargeTitles = true
		let settingsNavVc = setUpNavigationController(image: UIImage(systemName: "gearshape"), viewController: SettingsViewController())
        
		//pra nav bar não aparecer na tela do mapa
		mapNavVc.isNavigationBarHidden = true
		
		mapNavVc.title = "Map"
		pinNavVc.title = "Pins"
		settingsNavVc.title = "Settings"
		
		//adicionando as view controllers apresentadas pela tab bar controller
		viewControllers = [mapNavVc, pinNavVc, settingsNavVc]
		
	}
	
	//cria um navigation controller com uma view controller dentro dele
	func setUpNavigationController(image: UIImage?, viewController: UIViewController) -> UINavigationController {

		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.tabBarItem.image = image
		return navigationController

	}
	
}
