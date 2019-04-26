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
    public static func searchInGoogleMaps(place: String, updates: @escaping (_ latitud: CLLocationDegrees, _ longitud: CLLocationDegrees) -> Void) {
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(place)&key=\(googleApiKey)"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: strGoogleApi)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            
            if error == nil {
                DispatchQueue.global(qos: .userInitiated).async {
                    let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    if let dictionary = jsonDict as? [String : Any] {
                        if let results = dictionary["results"] as? [Any], results.count > 0 {
                            if let result = results[0] as? [String : Any] {
                                if let geometry = result["geometry"] as? [String : Any] {
                                    if let location = geometry["location"] as? [String : Any] {
                                        if let lat = location["lat"] as? CLLocationDegrees, let lng = location["lng"] as? CLLocationDegrees {
                                            DispatchQueue.main.async {
                                                updates(lat, lng)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                print("Something went wrong")
            }
        }
        
        task.resume()
    }
}
