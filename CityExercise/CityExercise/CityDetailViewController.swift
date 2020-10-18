//
//  CityDetailViewController.swift
//  CityExercise
//
//  Created by Cleís Aurora Pereira on 17/10/20.
//

import UIKit
import MapKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var stateLabel: UILabel!

    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet weak var numberPeopleLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!
    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = city?.name
        stateLabel.text = city?.state
        countryLabel.text = city?.country
        numberPeopleLabel.text = "\(city!.numberPeople)"
        temperatureLabel.text = "\(city!.temperature)"

        centerMapOnLocation(location: city!.coordinates.coordinate, title: city!.name)
    }

    func centerMapOnLocation(location: CLLocationCoordinate2D, title: String) {
        let coordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        self.mapView.addAnnotation(annotation)
      }

    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
