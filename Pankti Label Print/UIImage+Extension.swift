//
//  UIImage+Extension.swift
//  Pankti Label Print
//
//  Created by bhanuteja on 27/12/23.
//

import UIKit

extension UIImage {
    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
}
