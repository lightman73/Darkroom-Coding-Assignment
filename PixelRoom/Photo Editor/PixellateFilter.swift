//
//  PixellateFilter.swift
//  PixelRoom
//
//  Created by Igor Lipovac on 01/03/2021.
//

import UIKit

class PixellateFilter {
    private let context = CIContext()
    private let internalFilter = CIFilter(name: "CIPixellate")

    func pixelate(image: UIImage, inputScale: Float) -> UIImage? {
        guard let inputCGImage = image.cgImage else {
            return nil
        }
        
        guard let pixellatedCGImage = pixellate(image: inputCGImage, inputScale: inputScale) else {
            return nil
        }
        
        return UIImage(cgImage: pixellatedCGImage)
    }
    
    func pixellate(image: CGImage, inputScale: Float) -> CGImage? {
        guard let filter = internalFilter else {
            return nil
        }
        
        // CFPixellate requires a minimum inputScale value of 1.0
        // If inputScale is less than 1.0, let's return the original
        // image and don't apply the filter
        if inputScale < 1.0 {
            return image
        }
        
        let inputImage = CIImage(cgImage: image)
        let center = CGPoint(x: inputImage.extent.width / 2, y: inputImage.extent.height / 2)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(CIVector(cgPoint: center), forKey: "inputCenter")
        filter.setValue(NSNumber(value: inputScale), forKey: "inputScale")
        
        guard let outputImage = filter.outputImage,
              let outputCGImage = context.createCGImage(outputImage, from: inputImage.extent)
        else {
            return nil
        }
        
        return outputCGImage
    }
}
