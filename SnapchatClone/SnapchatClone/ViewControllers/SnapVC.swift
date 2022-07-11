//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 17.04.2022.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SnapVC: UIViewController {
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    var selectedSnap : Snap?

    var inputArray = [KingfisherSource]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        

        
        if let snap = selectedSnap{
            
            TimeLabel.text = "Time Left: \(snap.timeDifference)"
            
            for imageURL in snap.imageURLArray{
                inputArray.append(KingfisherSource(urlString: imageURL)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 30, y: 30, width: self.view.frame.width*0.95, height: self.view.frame.height*0.9))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIView.ContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            
            self.view.bringSubviewToFront(TimeLabel)
            
            
            /*
            self.TimeLabel.bringSubviewToFront(self.grandchildview.superview!)
            self.grandchildview.superview!.bringSubviewToFront(self.grandchildview)
            */
            
        }
        
        
    }
    


}
