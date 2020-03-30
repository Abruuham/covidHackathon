//
//  Extensions.swift
//  covidTracker
//
//  Created by Abraham Calvillo on 3/25/20.
//  Copyright © 2020 AbrahamCalvillo. All rights reserved.
//

import Foundation
import MapKit
import UIKit

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.administrativeArea, $1) }
    }
}
