//
//  EncodeTextToPDFManager.swift
//  TestPDFToText
//
//  Created by 현수빈 on 6/21/24.
//

import Foundation
import PDFKit


final class DecoderManager {

    func excute(fileName: String, password: String) -> String? {
        // Function to extract text from a password-protected PDFfunc extractText(fromPDF fileName: String, password: String) -> String? {
        // Get the PDF file URL
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        // Open the PDF document
        guard let pdfDocument = PDFDocument(url: fileURL) else {
            print("Failed to open PDF document")
            return nil
        }
        
        // Unlock the PDF document
        if !pdfDocument.unlock(withPassword: password) {
            print("Failed to unlock PDF document")
            return nil
        }
        
        // Extract text from all pages
        var text = ""
        for pageIndex in 0..<pdfDocument.pageCount {
            if let page = pdfDocument.page(at: pageIndex) {
                if let pageContent = page.string {
                    text += pageContent
                }
            }
        }
        
        return text
    }
}
