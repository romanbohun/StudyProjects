//
//  ViewController.swift
//  Work with Maps
//
//  Created by Roman Bogun on 25.02.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    private let _actionStackView: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()

    private let _citySegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(frame: .zero)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.insertSegment(withTitle: "Kyiv", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Tallinn", at: 1, animated: true)
        segmented.insertSegment(withTitle: "New York", at: 2, animated: true)
        segmented.insertSegment(withTitle: "Chicago", at: 3, animated: true)
        segmented.insertSegment(withTitle: "London", at: 4, animated: true)
        segmented.selectedSegmentIndex = 0

        return segmented
    }()

    private let _map: MKMapView = {
        var map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    private let _mapTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Type", for: .normal)

        return button
    }()

    private let _map3dButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("3d", for: .normal)

        return button
    }()

    private let _mapFeaturesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Features", for: .normal)

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

        _citySegmented.addTarget(self, action: #selector(segmentedControlAction), for: .valueChanged)

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

    @objc private func segmentedControlAction(control: UISegmentedControl) {
        print("selected index -> \(control.selectedSegmentIndex)")
    }

}

extension UIButton {

    func applyCustomStyle() -> UIButton {
        self.backgroundColor = .white
        self.setTitleColor(.blue, for: .normal)
        return self
    }

}
