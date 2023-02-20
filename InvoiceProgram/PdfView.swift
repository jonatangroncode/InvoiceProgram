//
//  PdfView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-18.
//

import SwiftUI
import PDFKit


var context = UIGraphicsGetCurrentContext
struct PdfView: View {
    
    var body: some View {
        VStack {
            Text("Invoice")
                .font(.title)
                .padding(.top, 5)
                .zIndex(1)
            PDFKitRepresentedView(pdfDocument: createInvoicePDF())
            
                .padding()
        
            
        }
        
    }
    struct PDFKitRepresentedView: UIViewRepresentable {
        var pdfDocument = PDFDocument()
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.document = pdfDocument
            return pdfView
            
        }
        func updateUIView(_ uiView: PDFView, context: Context) {
            uiView.document = pdfDocument
        }
        
    }
    
}
private func createInvoicePDF() -> PDFDocument {
    // create the PDF document and add a page with the invoice details
    let pdfDocument = PDFDocument()
    let page = PDFPage()
    let pageBounds = page.bounds(for: .cropBox)
    
    // add text to the PDF page
    let text = "Hello, world! This is some sample text for testing purposes."
    
    let textFont = UIFont.systemFont(ofSize: 12)
    let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: UIColor.black]
    
    // draw the text on the page
    UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
   // let context = UIGraphicsGetCurrentContext()
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    let textSize = attributedText.size()
    let textRect = CGRect(x: (pageBounds.width - textSize.width) / 2.0,
                          y: (pageBounds.height - textSize.height) / 2.0,
                          width: textSize.width,
                          height: textSize.height)
    attributedText.draw(in: textRect)
    UIGraphicsEndPDFContext()
    
    // add the page to the PDF document
    pdfDocument.insert(page, at: pdfDocument.pageCount)
    
    return pdfDocument
}


/*private func createInvoicePDF() -> PDFDocument {
    // create the PDF document and add a page with the invoice details
    let pdfDocument = PDFDocument()
    let page = PDFPage()
    let pageBounds = page.bounds(for: .cropBox)
    
    // add text to the PDF page
    let text = "Hello, world! This is some red text."
    
    let textFont = UIFont.systemFont(ofSize: 14)
    let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: UIColor.red]
    
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    let textRect = CGRect(x: pageBounds.midX, y: pageBounds.midY, width: 250, height: 50)
    attributedText.draw(in: textRect)
    
    // add the page to the PDF document
    pdfDocument.insert(page, at: pdfDocument.pageCount)
    
    return pdfDocument
}*/

/*
    private func createInvoicePDF() -> PDFDocument {
        
        // create the PDF document and add a page with the invoice details
        let pdfDocument = PDFDocument()
        let page = PDFPage()
        let pageBounds = page.bounds(for: .cropBox)
        
        // add text to the PDF page
        let text = "Hello, world hoppas det är bra och att jag kan se texten!"
        
        let textFont = UIFont.systemFont(ofSize: 25)
        let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: UIColor.black]
        
        //let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont]
        let attributedText = NSAttributedString(string: text, attributes:textAttributes)
        
        let textRect = CGRect(x: pageBounds.midX, y: pageBounds.midY, width: 55, height: 55).insetBy(dx: -72, dy: -72)
        attributedText.draw(in: textRect)
        
        // add the page to the PDF document
        pdfDocument.insert(page, at: pdfDocument.pageCount)
        
        
        return pdfDocument
    }
}
*/

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
    PdfView()
}
}
