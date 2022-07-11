//
//  detailsVC.swift
//  SimpsonBook
//
//  Created by MSUBASI on 2.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class detailsVC: UIViewController {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var JobLabel: UILabel!
    
    var selectedSimpson : Simpsons?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NameLabel.text = selectedSimpson?.name
        JobLabel.text = selectedSimpson?.job
        ImageView.image = selectedSimpson?.image
        
    }
    

    
    
    
    

}
