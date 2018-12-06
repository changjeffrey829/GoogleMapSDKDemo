//
//  CoorindatesAddressView.swift
//  GoogleMapSDKDemo
//
//  Created by Jeffrey Chang on 12/3/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

protocol CoodinateAddressDelegate: class {
    func tappedLocationButton()
    func tappedSearch(text: String?)
}

class CoordinateAddressView: UIView {
    
    weak var delegate: CoodinateAddressDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    @objc func tappedLocationButton() {
        delegate?.tappedLocationButton()
    }
    
    @objc func tappedSearch() {
        delegate?.tappedSearch(text: coorindatesTextfield.text)
    }
    
    private func setupViews() {
        let buttonStackView = UIStackView(arrangedSubviews: [currentLocationButton, searchButton])
        buttonStackView.spacing = 3
        buttonStackView.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [coorindatesTextfield, buttonStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    lazy var coorindatesTextfield: UITextField = {
        let tf = UITextField()
        tf.setLeftPaddingPoints(8)
        tf.placeholder = "Latitude, Longitude"
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1
        return tf
    }()
    
    lazy var currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Current Location", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tappedLocationButton), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tappedSearch), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
