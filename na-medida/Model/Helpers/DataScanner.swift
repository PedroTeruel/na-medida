//
//  DataScanner.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 30/09/26.
//

import SwiftUI
import VisionKit

struct DataScanner: UIViewControllerRepresentable {
    @Binding var scannerCode: String?
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isHighlightingEnabled: true)
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            try? uiViewController.startScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanner
        
        init(_ parent: DataScanner) {
            self.parent = parent
        }
        
        func dataScanner(_dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            if let item = addedItems.first, case .barcode(let barcode) = item {
                parent.scannerCode = barcode.payloadStringValue
            }
        }
    }
    
}
