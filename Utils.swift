//
//  Utils.swift
//  covidHackathon
//
//  Created by Abraham Calvillo on 3/29/20.
//  Copyright © 2020 AbrahamCalvillo. All rights reserved.
//

import Foundation
import UIKit

//******************************
// MARK: Array of items
//******************************
public let COLLECTION_LIST: [(title: String, backgroundImage: UIImage)] = [
    (title: "Map", backgroundImage: UIImage(named: "map")! ),
    (title: "News", backgroundImage: UIImage(named: "news")!),
    (title: "Hospital", backgroundImage: UIImage(named: "hospital")!),
    (title: "Stay-home ideas", backgroundImage: UIImage(named: "idea")!)
]

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family:'-apple-system', 'HelveticaNeue'; font-size: \(16)\">%@</span>", htmlText)

        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)


        self.attributedText = attrStr
    }
}
