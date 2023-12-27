//
//  ViewController.swift
//  Pankti Label Print
//
//  Created by bhanuteja on 27/12/23.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var generatePdfButton: UIButton!
    @IBOutlet weak var printView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var barcodeImageView: UIImageView!
        
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mrpLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToLabels(labels: [titleLabel,
                                    descLabel,
                                    barcodeLabel,
                                    sizeLabel,
                                    colorLabel,
                                    dateLabel,
                                    mrpLabel])
        // Do any additional setup after loading the view.
    }
    
    private func addGestureToLabels(labels: [UILabel]) {
        labels.forEach { label in
            label.addUserInteration(target: self, action: #selector(tapFunction))
        }
    }

    @IBAction func generatePdfAction(_ sender: Any) {
        let path = printView.exportAsPdfFromView(title: self.titleLabel.text ?? "")
        print("path is", path)
        let viewer = UIDocumentInteractionController(url: URL(filePath: path))
        viewer.delegate = self
        viewer.presentPreview(animated: true)
    }
    
    @objc
    func tapFunction(sender: UITapGestureRecognizer) {
        if let labelView = sender.view as? UILabel {
            showAlertView(label: labelView)
        }
    }
     
    private func showAlertView(label: UILabel) {
         let alertController = UIAlertController(title: "Pankti",
                                                 message: "Edit \(label.text ?? "")",
                                                 preferredStyle: .alert)

         alertController.addTextField { (textField) in
             // configure the properties of the text field
             textField.placeholder = "Name"
         }

         // add the buttons/actions to the view controller
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         let saveAction = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
             let inputName = alertController.textFields![0].text
             label.text = inputName
             if label.tag == 12 {
                 self?.barcodeImageView.image = UIImage(barcode: inputName ?? "Default")
                 self?.barcodeImageView.contentMode = .center
             }
         }
         alertController.addAction(cancelAction)
         alertController.addAction(saveAction)
         
         present(alertController, animated: true)
     }
    
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    private func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController!) -> UIView! {
        return self.view
    }
    
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
}



