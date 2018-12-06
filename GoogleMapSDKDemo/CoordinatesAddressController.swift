//
//  ViewController.swift
//  GoogleMapSDKDemo
//
//  Created by Jeffrey Chang on 12/1/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import GoogleMaps

class CoordinatesAddressController: UIViewController, CLLocationManagerDelegate {
    
    
    var locationManager: CLLocationManager?
    var mapView: GMSMapView?
    let coorindateAddressView = CoordinateAddressView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Convert Coordinates to Address"
        setupLocationManager()
        setupGoogleMap()
        setupViews()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0].coordinate
        coorindateAddressView.coorindatesTextfield.text = "\(userLocation.latitude), \(userLocation.longitude)"
        manager.stopUpdatingLocation()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func setupGoogleMap() {
        GMSServices.provideAPIKey("AIzaSyAv13WFjzJssOU9vzl67VW3cUVD2ww52sY")
        
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
    
    private func setupViews() {
        coorindateAddressView.delegate = self
        var coorindateAddressViewHeight:CGFloat = 0
        view.addSubview(coorindateAddressView)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let windowHeight = appDelegate.window?.frame.height {
            coorindateAddressViewHeight = windowHeight
        }
        coorindateAddressView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: coorindateAddressViewHeight / 8)
    }
    
  
}

extension CoordinatesAddressController: CoodinateAddressDelegate {
    func tappedLocationButton() {
        locationManager?.startUpdatingLocation()
    }
    
    func tappedSearch(text: String?) {
        guard
            let textArray = text?.replacingOccurrences(of: " ", with: "").components(separatedBy: ","),
            let latFloat = Float(textArray[0]),
            let longFloat = Float(textArray[1]),
            let lat = CLLocationDegrees(exactly: latFloat),
            let long = CLLocationDegrees(exactly: longFloat) else {return}
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let marker = GMSMarker(position: coordinates)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15)
        marker.map = mapView
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinates) { (response, err) in
            if let address = response?.results()?.first {
                marker.title = text
                marker.snippet = address.thoroughfare
                
            }
            
        }
        view.endEditing(false)
    }
    
}

