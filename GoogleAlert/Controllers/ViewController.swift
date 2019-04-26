//
//  ViewController.swift
//  GoogleAlert
//
//  Created by Osmar Hernández on 25/04/19.
//  Copyright © 2019 tallervertical. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func goToLevelEmergencyView(_ sender: UIButton) {
        performSegue(withIdentifier: "levelEmergencySegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "levelEmergencySegue" {
            if let button = sender as? UIButton {
                var emergencyType: EmergencyType = .unasigned
                
                // TODO: The current title is nil for Proteccion Civil
                switch button.currentTitle {
                case "POLICIA":
                    emergencyType = .police
                case "BOMBEROS":
                    emergencyType = .firefighters
                case "PROTECCION CIVIL":
                    emergencyType = .civilprotection
                case "AMBULANCIA":
                    emergencyType = .ambulance
                default:
                    emergencyType = .civilprotection
                }
                
                if let navigationController = segue.destination as? UINavigationController {
                    if let levelEmergencyVC = navigationController.topViewController as? LevelEmergencyViewViewController {
                        levelEmergencyVC.emergencyType = emergencyType
                    }
                }
            }
        }
    }
}

