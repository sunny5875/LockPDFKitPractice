//
//  EncodeManager.swift
//  TestPDFToText
//
//  Created by 현수빈 on 6/21/24.
//

import PDFKit
import UIKit

final class EncodeManager {
    
    func execute(password: String, text: String , fileName: String) {
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        
        // Create a PDF page with the text
        let pdfPage = PDFPage()
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let data = renderer.pdfData { context in
            context.beginPage()
            let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)
            attributedText.draw(in: pageRect.insetBy(dx: 20, dy: 20))
        }
        
        
        let pdfDocument = PDFDocument(data: data)
        
        // Save the PDF document with password protection
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        if ((pdfDocument?.write(to: fileURL, withOptions: [.userPasswordOption : password, .ownerPasswordOption: password])) != nil) {
            print("PDF saved to: \(fileURL.path)")
        } else {
            print("Failed to save PDF")
        }
    }
}
