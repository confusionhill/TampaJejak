//
//  QRCodeService.swift
//  TampaJejak
//
//  Created by Farhandika on 13/05/22.
//

import UIKit
import CoreImage.CIFilterBuiltins

enum QRError: Error {
    case qrNil
}
extension QRError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .qrNil:
            return NSLocalizedString("QR Code cannot be formed", comment: "QR Error")
        }
    }
}

class QRCodeService {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    public func generateQRCode(
        message: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        filter.message = Data(message.utf8)
        if let outputImage = filter.outputImage {
            do {
                let img = try getQRImage(outputImage: outputImage)
                completion(.success(img))
            } catch (let e) {
                completion(.failure(e))
            }
        }

    }
    
    private func getQRImage(outputImage: CIImage) throws -> UIImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        } else {
            throw QRError.qrNil
        }
    }
}
