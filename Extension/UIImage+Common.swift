//
//  UIImage+Common.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/18.
//

import UIKit
import SDWebImage

extension UIImage {
    
    static func createQRCode(_ str: String, withSize size: CGFloat = 50) -> UIImage? {
        let data = str.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {return nil}
            
            let originSize = QRImage.extent.size
            let scale = min(size/originSize.width, size/originSize.height)
            let transformScale = CGAffineTransform(scaleX: scale, y: scale)
            let scaledQRImage = QRImage.transformed(by: transformScale)
            
            return UIImage(ciImage: scaledQRImage)
        }
        return nil
    }
    
}

extension UIImage {
    
    static func createWithColor(_ color: UIColor, size: CGSize = .init(width: 40, height: 40)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(.init(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    convenience init(cvPixelBuffer: CVPixelBuffer) {
        let ciimage = CIImage(cvPixelBuffer: cvPixelBuffer)
        self.init(ciimage: ciimage)
    }
    
    convenience init(ciimage: CIImage) {
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(ciimage, from: ciimage.extent)!
        self.init(cgImage: cgImage)
    }
    
    
    func resizedImage(with size: CGSize) -> UIImage? {
        let image = sd_resizedImage(with: size, scaleMode: .aspectFit)
        return image
    }
}

/// 仅用来寻找bundle
fileprivate
class Goat {
    
}

fileprivate let goatBundle = Bundle(for: Goat.self)

extension UIImage {
    
    static func bundleImage(_ name: String?) -> UIImage? {
        guard let v = name else {
            return nil
        }
        return UIImage(named: v, in: goatBundle, compatibleWith: nil)
    }
}
