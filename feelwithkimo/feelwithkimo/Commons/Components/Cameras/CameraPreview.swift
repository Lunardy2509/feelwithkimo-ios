//
//  CameraPreview.swift
//  feelwithkimo
//
//  Created by jonathan calvin sutrisna on 26/10/25.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    @Binding var orientation: UIDeviceOrientation

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        let previewLayer = view.videoPreviewLayer
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        guard let connection = uiView.videoPreviewLayer.connection else { return }

        #if compiler(>=5.9)
        
        if connection.isVideoRotationAngleSupported(0),
           connection.isVideoRotationAngleSupported(180) {
            
            switch orientation {
            case .landscapeLeft:
                connection.videoRotationAngle = 180

            case .landscapeRight:
                connection.videoRotationAngle = 0

            default:
                break
            }
        }
        #else
        if connection.isVideoOrientationSupported {
            let orientation = UIDevice.current.orientation

            switch orientation {
            case .landscapeLeft:
                connection.videoOrientation = .landscapeLeft
            case .landscapeRight:
                connection.videoOrientation = .landscapeRight
            default:
                break
            }
        }
        #endif
    }
}

/// UIView subclass agar layer-nya otomatis menjadi AVCaptureVideoPreviewLayer
final class PreviewView: UIView {
    override static var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected AVCaptureVideoPreviewLayer but got \(type(of: layer))")
        }
        return layer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = bounds
    }
}
