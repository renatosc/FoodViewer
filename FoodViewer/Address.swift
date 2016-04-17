//
//  Address.swift
//  FoodViewer
//
//  Created by arnaud on 24/03/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import Foundation
import MapKit

class Address {
    
    internal struct Notification {
        static let CoordinateHasBeenSet = "Address.Notification.CoordinateHasBeenSet"
        static let CoordinateHasBeenSetForAddressKey = "Address.Notification.CoordinateHasBeenSet.Key"
    }

    var title = ""
    var street = ""
    var city = ""
    var postalcode = ""
    var country = ""    
    var elements: [String]? = nil
        /*
 {
        didSet {
            if (elements != nil) && (!elements!.isEmpty) {
                elements = removeDashes(elements!)
                // retrieveCoordinates(elements!.joinWithSeparator(" "))
            }
        }
    }
 */
    var language: String = ""
    var coordinates: [CLLocationCoordinate2D]? = nil {
        didSet {
            if coordinates != nil {
                let userInfo = [Notification.CoordinateHasBeenSetForAddressKey:self]
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.CoordinateHasBeenSet, object:nil, userInfo: userInfo)
            }
        }
    }
    
    func getCoordinates() -> [CLLocationCoordinate2D]? {
        setCoordinates()
        return coordinates
    }
    
    
    func setCoordinates() {
        if coordinates == nil {
            // launch the image retrieval
            if (elements != nil) && (!elements!.isEmpty) {
                elements = removeDashes(elements!)
                retrieveCoordinates(elements!.joinWithSeparator(" "))
            } else if !country.isEmpty {
                retrieveCoordinates(country)
            }
        }
    }
    

    
    /*
    var languageCountry = "" {
        didSet {
            if !languageCountry.isEmpty {
                let countryDictArray = splitLanguageElements([languageCountry])
                let countryDict = countryDictArray!.first
                (language, country) = countryDict!.first!
                retrieveCoordinates(country)
            }

        }
    }
 */
    
    func joined() -> String? {
        return elements?.joinWithSeparator(" ")
    }
    
    func retrieveCoordinates(locationName: String) {
        var coordinates: [CLLocationCoordinate2D]? =  nil

        if !locationName.isEmpty {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(locationName) { (placemarks, error) -> Void in
                if error != nil {
                    print("Geocode failed with error: \(error!.localizedDescription) for \(locationName)")
                } else {
                    coordinates = []
                    if let validPlacemarks = placemarks {
                        for placemark in validPlacemarks {
                            if let validLocation = placemark.location {
                                coordinates!.append(validLocation.coordinate)
                            }
                        }
                        self.coordinates = coordinates
                    }
                }
            }
        }
    }
    
    // This function splits an element in an array in a language and value part
    func splitLanguageElements(inputArray: [String]?) -> [[String: String]]? {
        if let elementsArray = inputArray {
            if !elementsArray.isEmpty {
                var outputArray: [[String:String]] = []
                for element in elementsArray {
                    let elementsPair = element.characters.split{$0 == ":"}.map(String.init)
                    let dict = Dictionary(dictionaryLiteral: (elementsPair[0], elementsPair[1]))
                    outputArray.insert(dict, atIndex: 0)
                }
                return outputArray
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    func removeDashes(array: [String]) -> [String] {
        var newArray: [String] = []
        for element in array {
            newArray.append(removeDashes(element))
        }
        return newArray
    }

    func removeDashes(element: String) -> String {
        var newElement = ""
        for character in element.characters {
            if character == "-" {
                newElement.appendContentsOf(" ")
            } else {
                newElement.append(character)
            }
        }
        return newElement
    }
}
