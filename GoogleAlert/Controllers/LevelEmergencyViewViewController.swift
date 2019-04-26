//
//  LevelEmergencyViewViewController.swift
//  GoogleAlert
//
//  Created by Osmar Hernández on 25/04/19.
//  Copyright © 2019 tallervertical. All rights reserved.
//

import UIKit

class LevelEmergencyViewViewController: UIViewController {
    
    var emergencyType: EmergencyType!
    
    @IBAction func gotToMapView(_ sender: UIButton) {
        performSegue(withIdentifier: "mapViewSegue", sender: sender)
    }
    
    @IBAction func goBackToMainView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let type = emergencyType else {
            return
        }
        
        if segue.identifier == "mapViewSegue" {
            if let button = sender as? UIButton, button.backgroundColor != nil {
                let mapViewController = segue.destination as! MapViewController
                mapViewController.emergencyColor = button.backgroundColor!
                mapViewController.emergencyType = type
            }
        }
    }
}
