//
//  MapViewModel.swift
//  Work with Maps
//
//  Created by Roman Bogun on 15.03.2021.
//

struct MapViewModel {

    let cities: [City]
    let zoom: Double = 500

    init() {
        cities = [
            City(
                name: "Kyiv",
                coordinates: Coordinates(latitude: 50.4501, longitude: 30.5234),
                viewSettings: MapSettings(heading: 90.0, altitude: 1500)),
            City(
                name: "Tallinn",
                coordinates: Coordinates(latitude: 59.4370, longitude: 24.7536),
                viewSettings: MapSettings(heading: 12.0, altitude: 1500)),
            City(
                name: "New York",
                coordinates: Coordinates(latitude: 40.7216294, longitude: -73.995453),
                viewSettings: MapSettings(heading: 180, altitude: 3000)),
            City(
                name: "Chicago",
                coordinates: Coordinates(latitude: 41.892479, longitude: -87.6267592),
                viewSettings: nil),
            City(
                name: "London",
                coordinates: Coordinates(latitude: 51.5074, longitude: 0.1278),
                viewSettings: nil),
        ]
    }

}

