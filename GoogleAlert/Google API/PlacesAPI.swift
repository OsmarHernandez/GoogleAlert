//
//  PlacesAPI.swift
//  GoogleAlert
//
//  Created by Osmar Hernández on 26/04/19.
//  Copyright © 2019 tallervertical. All rights reserved.
//

import Foundation
import GoogleMaps

struct PlaecesAPI {
    private static let baseURLString = "https://maps.googleapis.com/maps/api/place/textsearch"
    
    private static func url(_ place: String) -> URL {
        var stringURL = "\(baseURLString)/json?query=\(place)&key=\(googleApiKey)"
        stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        return URL(string: stringURL)!
    }
    
    public static func searchInGoogleMaps(place: String, completion: @escaping (_ latitud: CLLocationDegrees, _ longitud: CLLocationDegrees) -> Void) {
        let url = self.url(place)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            
            if error == nil {
                if let data = data {
                    let (latitude, longitude) = position(data: data)
                    OperationQueue.main.addOperation {
                        completion(latitude, longitude)
                    }
                }
            } else {
                print("Something went wrong")
            }
        }
        
        task.resume()
    }
    
    private static func position(data: Data) -> (CLLocationDegrees, CLLocationDegrees) {
        var latitud: CLLocationDegrees = 0.0
        var longigude: CLLocationDegrees = 0.0
        
        let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        if let dictionary = jsonDict as? [String : Any] {
            if let results = dictionary["results"] as? [Any], results.count > 0 {
                let result = results[0] as! [String : Any]
                let geometry = result["geometry"] as! [String : Any]
                let location = geometry["location"] as! [String : Any]
                
                latitud = location["lat"] as! CLLocationDegrees
                longigude = location["lng"] as! CLLocationDegrees
            }
        }
        
        return (latitud, longigude)
    }
}
