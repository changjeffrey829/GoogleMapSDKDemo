//
//  AddressAutocompleteVC.swift
//  GoogleMapSDKDemo
//
//  Created by Jeffrey Chang on 12/5/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddressAutocompleteVC: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Address Autocomplete"
        view.backgroundColor = .blue
        setupNavItem()
        setupGoogleMap()
    }
    
    private func setupGoogleMap() {
        GMSServices.provideAPIKey("AIzaSyAv13WFjzJssOU9vzl67VW3cUVD2ww52sY")
        GMSPlacesClient.provideAPIKey("AIzaSyAv13WFjzJssOU9vzl67VW3cUVD2ww52sY")
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        guard let gestureRecognizers = mapView?.gestureRecognizers else {return}
        for (index,gesture) in gestureRecognizers.enumerated() {
            if index == 0 {
                mapView?.removeGestureRecognizer(gesture)
            }
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("did complete autocomplete vc")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchLocation(){
        let vc = GMSAutocompleteViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    private func setupNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchLocation))
    }
}
