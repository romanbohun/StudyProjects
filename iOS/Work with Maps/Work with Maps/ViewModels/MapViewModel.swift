//
//  MapViewModel.swift
//  Work with Maps
//
//  Created by Roman Bogun on 15.03.2021.
//

struct MapViewModel {

    let cities: [City]
    let zoom: Double = 1000

    init() {
        let coordinatesKyiv = Coordinates(latitude: 50.4501, longitude: 30.5234)
        let coordinatesTallinn = Coordinates(latitude: 59.4370, longitude: 24.7536)
        let coordinatesNewYork = Coordinates(latitude: 40.7216294, longitude: -73.995453)
        let coordinatesChicago = Coordinates(latitude: 41.892479, longitude: -87.6267592)
        let coordinatesLondon = Coordinates(latitude: 51.5074, longitude: 0.1278)

        cities = [
            City(name: "Kyiv", coordinates: coordinatesKyiv),
            City(name: "Tallinn", coordinates: coordinatesTallinn),
            City(name: "New York", coordinates: coordinatesNewYork),
            City(name: "Chicago", coordinates: coordinatesChicago),
            City(name: "London", coordinates: coordinatesLondon),
        ]
    }

}

