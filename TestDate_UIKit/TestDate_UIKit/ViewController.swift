//
//  ViewController.swift
//  TestDate_UIKit
//
//  Created by 이선준 on 1/2/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var images: [UIImage] = []
    let imageFiles = [
        "1.jpg", "2.png", "3.jpeg",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for imageFile in imageFiles {
            let image: UIImage = UIImage(named: imageFile) ?? UIImage(systemName: "photo.tv")!
            
            images.append(image)
        }
        imageView.image = images.first
    }
    

    @IBAction func changeImages(_ sender: UIButton) {
        
    }
}

