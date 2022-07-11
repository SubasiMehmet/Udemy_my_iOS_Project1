//
//  ImageViewContoller.swift
//  LandmarkBook
//
//  Created by MSUBASI on 31.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ImageViewContoller: UIViewController {

    
    
    @IBOutlet weak var LandmarkImageView: UIImageView!
    @IBOutlet weak var LandmarkLabel: UILabel!
    
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LandmarkLabel.text = selectedLandmarkName
        LandmarkImageView.image = selectedLandmarkImage
    }
    

    

}
