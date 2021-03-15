//
//  ViewController.swift
//  Work with Maps
//
//  Created by Roman Bogun on 25.02.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    private var _viewModel = MapViewModel()
    private var interests: [MKPointOfInterestCategory] = []

    private let _actionStackView: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()

    private lazy var _citySegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(frame: .zero)
        segmented.translatesAutoresizingMaskIntoConstraints = false

        for cityItem in _viewModel.cities.enumerated() {
            segmented.insertSegment(withTitle: cityItem.element.name, at: cityItem.offset, animated: true)
        }

        segmented.addTarget(self, action: #selector(segmentedControlAction), for: .valueChanged)
        segmented.selectedSegmentIndex = 0
        return segmented
    }()

    private let _map: MKMapView = {
        var map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isRotateEnabled = true
        map.isScrollEnabled = true
        return map
    }()

    private lazy var _mapTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Type", for: .normal)
        button.addTarget(self, action: #selector(changeMapType), for: .touchUpInside)
        return button
    }()

    private lazy var _map3dButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("3d", for: .normal)
        button.addTarget(self, action: #selector(changePitch), for: .touchUpInside)
        return button
    }()

    private lazy var _mapFeaturesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Features", for: .normal)
        button.addTarget(self, action: #selector(toggleMapFeatures), for: .touchUpInside)
        return button
    }()

    private let _mapHereButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Here", for: .normal)

        return button
    }()

    private let _mapFindButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Find", for: .normal)

        return button
    }()

    private let _view1: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let _view2: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(_actionStackView)
        view.addSubview(_map)
        view.addSubview(_citySegmented)

        _actionStackView.addArrangedSubview(_mapTypeButton.applyCustomStyle())
        _actionStackView.addArrangedSubview(_map3dButton.applyCustomStyle())
        _actionStackView.addArrangedSubview(_mapFeaturesButton.applyCustomStyle())
        _actionStackView.addArrangedSubview(_mapHereButton.applyCustomStyle())
        _actionStackView.addArrangedSubview(_mapFindButton.applyCustomStyle())

        segmentedControlAction(_citySegmented)

        let actionStackViewLeadingConstraint = _actionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let actionStackViewTopConstraint = _actionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let actionStackViewTrailingConstraint = view.trailingAnchor.constraint(equalTo: _actionStackView.trailingAnchor)
        let actionStackViewHeightConstraint = _actionStackView.heightAnchor.constraint(equalToConstant: 50)

        let switcherLeadingConstraint = _citySegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let switcherTrailingConstraint = view.trailingAnchor.constraint(equalTo: _citySegmented.trailingAnchor)
        let switcherBottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: _citySegmented.bottomAnchor)
        let switcherHeightConstraint = _citySegmented.heightAnchor.constraint(equalToConstant: 100)

        let mapLeadingConstraint = _map.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let mapTrailingConstraint = view.trailingAnchor.constraint(equalTo: _map.trailingAnchor)
        let mapTopConstraint = _map.topAnchor.constraint(equalTo: _actionStackView.bottomAnchor)
        let mapBottomConstraint = _citySegmented.topAnchor.constraint(equalTo: _map.bottomAnchor)

        NSLayoutConstraint.activate([
            actionStackViewLeadingConstraint,
            actionStackViewTopConstraint,
            actionStackViewTrailingConstraint,
            actionStackViewHeightConstraint,
            switcherLeadingConstraint,
            switcherTrailingConstraint,
            switcherBottomConstraint,
            switcherHeightConstraint,
            mapLeadingConstraint,
            mapTrailingConstraint,
            mapTopConstraint,
            mapBottomConstraint
        ])
    }

    @objc private func segmentedControlAction(_ control: UISegmentedControl) {
        let city = _viewModel.cities[control.selectedSegmentIndex]
        let coordinates2D = CLLocationCoordinate2DMake(city.coordinates.latitude, city.coordinates.longitude)

        if let settings = city.viewSettings {
            updateMapCamera(coordinates: coordinates2D, heading: settings.heading, altitude: settings.altitude)
        } else {
            updateMapRegion(with: coordinates2D, rangeSpan: _viewModel.zoom)
        }
    }

}

// MARK: - Actions
extension ViewController {

    @objc private func changeMapType(_ sender: UIButton) {
        switch _map.mapType {
        case .standard:
            _map.mapType = .satellite
        case .satellite:
            _map.mapType = .hybrid
        case .hybrid:
            _map.mapType = .satelliteFlyover
        case .satelliteFlyover:
            _map.mapType = .hybridFlyover
        case .hybridFlyover:
            _map.mapType = .mutedStandard
        case .mutedStandard:
            _map.mapType = .standard
        @unknown default:
            fatalError()
        }
    }

    @objc private func changePitch(_ sender: UIButton) {
        _viewModel.pitch = (_viewModel.pitch + 15).truncatingRemainder(dividingBy: 90)
        sender.setTitle("\(_viewModel.pitch)º", for: .normal)
        _map.camera.pitch = CGFloat(_viewModel.pitch)
    }

    @objc private func toggleMapFeatures(_ sender: UIButton) {
        _viewModel.isOn = !_map.showsScale
        _map.showsScale = _viewModel.isOn
        _map.showsCompass = _viewModel.isOn
        _map.showsTraffic = _viewModel.isOn
        if _viewModel.isOn {
            let filters: [MKPointOfInterestCategory] = [
                .airport,
                .amusementPark,
                .aquarium,
                .atm,
                .bakery,
                .bank,
                .beach,
                .brewery,
                .cafe,
                .campground,
                .carRental,
                .evCharger,
                .fireStation,
                .fitnessCenter,
                .foodMarket,
                .gasStation,
                .hospital,
                .hotel,
                .laundry,
                .library,
                .marina,
                .movieTheater,
                .museum,
                .nationalPark,
                .nightlife,
                .park,
                .parking,
                .pharmacy,
                .police,
                .postOffice,
                .publicTransport,
                .restaurant,
                .restroom,
                .school,
                .stadium,
                .store,
                .theater,
                .university,
                .winery,
                .zoo,
            ]
            _map.pointOfInterestFilter = MKPointOfInterestFilter(including:  filters)
        } else {
            _map.pointOfInterestFilter = MKPointOfInterestFilter(including: [])
        }
    }

}

// MARK: - Instance Methods
extension ViewController {

    func updateMapRegion(with coordinates: CLLocationCoordinate2D, rangeSpan: CLLocationDistance) {
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        _map.region = region
    }

    func updateMapCamera(
        coordinates: CLLocationCoordinate2D,
        heading: CLLocationDirection,
        altitude: CLLocationDistance
    ) {
        let camera = MKMapCamera()
        camera.centerCoordinate = coordinates
        camera.heading = heading
        camera.altitude = altitude
        camera.pitch = 0.0
        _map3dButton.setTitle("0º", for: .normal)
        _map.camera = camera
    }

}

