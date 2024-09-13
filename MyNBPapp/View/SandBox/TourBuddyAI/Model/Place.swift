//
//  Place.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/08/2024.
//

import Foundation

import SwiftUI
import CoreLocation

struct Placemark {
    let name: String
    let address: String
    let coordinates: CLLocationCoordinate2D
    let region: Region
}

struct Region {
    let identifier: String
    let center: CLLocationCoordinate2D
    let radius: CLLocationDistance
}


struct Place: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String?
    let placemark: Placemark
    let timeZone: String
    let url: URL?
    
    static let samplePlaces: [Place] = [
        Place(
            name: "MNK Sukiennice",
            phoneNumber: "+48 12 433 54 00",
            placemark: Placemark(
                name: "MNK Sukiennice",
                address: "Rynek Główny 3, 31-042 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06170350, longitude: 19.93759020),
                region: Region(
                    identifier: "<+50.06170351,+19.93759020> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06170351, longitude: 19.93759020),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: URL(string: "https://mnk.pl/")
        ),
        Place(
            name: "Pomnik Adama Mickiewicza",
            phoneNumber: "+48 12 616 18 86",
            placemark: Placemark(
                name: "Pomnik Adama Mickiewicza",
                address: "Rynek Główny 31, 31-010 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06146930, longitude: 19.93799800),
                region: Region(
                    identifier: "<+50.06146931,+19.93799800> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06146931, longitude: 19.93799800),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: URL(string: "https://www.krakow.pl/miasto_z_kultura/72764,artykul,pomnik_adama_mickiewicza.html")
        ),
        Place(
            name: "Wieża Ratuszowa",
            phoneNumber: "+48 12 426 43 34",
            placemark: Placemark(
                name: "Wieża Ratuszowa",
                address: "Rynek Główny 1, 31-042 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06137830, longitude: 19.93634460),
                region: Region(
                    identifier: "<+50.06137831,+19.93634460> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06137831, longitude: 19.93634460),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: URL(string: "https://muzeumkrakowa.pl/oddzialy/wieza-ratuszowa")
        ),
        Place(
            name: "Sukiennice",
            phoneNumber: "+48 12 422 11 66",
            placemark: Placemark(
                name: "Sukiennice",
                address: "Rynek Główny 1, 31-042 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06160900, longitude: 19.93728340),
                region: Region(
                    identifier: "<+50.06160901,+19.93728340> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06160901, longitude: 19.93728340),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: URL(string: "https://mnk.pl/oddzial/mnk-sukiennice")
        ),
        Place(
            name: "Eros Spętany",
            phoneNumber: nil,
            placemark: Placemark(
                name: "Eros Spętany",
                address: "Rynek Główny 1, 31-042 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06144710, longitude: 19.93637680),
                region: Region(
                    identifier: "<+50.06144711,+19.93637680> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06144711, longitude: 19.93637680),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: nil
        ),
        Place(
            name: "Collegium Maius",
            phoneNumber: "+48 12 663 13 07",
            placemark: Placemark(
                name: "Collegium Maius",
                address: "Jagiellońska 15, 31-010 Kraków, Polska",
                coordinates: CLLocationCoordinate2D(latitude: 50.06160000, longitude: 19.93400000),
                region: Region(
                    identifier: "<+50.06160001,+19.93400000> radius 141.18",
                    center: CLLocationCoordinate2D(latitude: 50.06160001, longitude: 19.93400000),
                    radius: 141.18
                )
            ),
            timeZone: "Europe/Warsaw (CEST)",
            url: URL(string: "http://www.maius.uj.edu.pl/")
        )
        // Dodaj inne miejsca w ten sam sposób
    ]
}

