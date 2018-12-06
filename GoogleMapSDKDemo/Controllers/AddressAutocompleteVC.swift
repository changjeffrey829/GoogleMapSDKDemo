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
    var locationManager: CLLocationManager?
    let defaultZoom:Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Address Autocomplete"
        setupNavItem()
        setupGoogleMap()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        updateLocation(place: place)
        dismiss(animated: true, completion: nil)
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
    
    private func setDefaultLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: defaultZoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = "Default"
        marker.map = mapView
    }
    
    private func setupGoogleMap() {
        GMSServices.provideAPIKey("AIzaSyAv13WFjzJssOU9vzl67VW3cUVD2ww52sY")
        GMSPlacesClient.provideAPIKey("AIzaSyAv13WFjzJssOU9vzl67VW3cUVD2ww52sY")
        setDefaultLocation(latitude: -33.86, longitude: 151.20)
        guard let gestureRecognizers = mapView?.gestureRecognizers else {return}
        for (index,gesture) in gestureRecognizers.enumerated() {
            if index == 0 {
                mapView?.removeGestureRecognizer(gesture)
            }
        }
    }
    
    private func updateLocation(place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: defaultZoom)
        mapView?.camera = camera
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
    }
    
    private func setupNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchLocation))
    }
}
