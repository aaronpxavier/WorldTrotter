//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by ladmin on 7/13/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView! = MKMapView()
    let layer: CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
        
    }
    
    private func changeTopLayerBg() {
        if self.view.bounds.width > self.view.bounds.height  {
            layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        } else {
            layer.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.007843137255, blue: 0.3490196078, alpha: 1).cgColor
        }
    }
    
    private func getTopBacgroundLayer() {
        layer.shouldRasterize = true
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    private func setMapView() {
        view = mapView
//        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        let standard = NSLocalizedString("Standard", comment: "Standard map view")
        let hybrid = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standard, hybrid, satelliteString])
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func loadView() {
        setMapView()
        getTopBacgroundLayer()
        changeTopLayerBg()
        view.layer.insertSublayer(layer, at: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeTopLayerBg()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
  
