//
//  String+Additions.swift
//  GoogleAlert
//
//  Created by Osmar Hernández on 26/04/19.
//  Copyright © 2019 tallervertical. All rights reserved.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
