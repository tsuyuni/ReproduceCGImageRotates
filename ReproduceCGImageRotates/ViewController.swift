//
//  ViewController.swift
//  ReproduceCGImageRotates
//
//  Created by Yuri Tsuchikawa on 2023/09/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onTapOpenCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage, let cgImage = image.cgImage, let fixedCGImage = image.fixedCGImage else { return }
        print(cgImage.width, cgImage.height) // Normal CGImage which rotates
        print(fixedCGImage.width, fixedCGImage.height) // Fixed CGImage which NOT rotates
        imageView.image = UIImage(cgImage: fixedCGImage)
    }
}

extension UIImage {
    
    var fixedCGImage: CGImage? {
        get {
            UIGraphicsBeginImageContext(self.size)
            let context = UIGraphicsGetCurrentContext()
            self.draw(at: .zero)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image?.cgImage
        }
    }
}
