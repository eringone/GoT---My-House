//
//  NowPlayingAnimation.swift
//  HokieCheer
//
//  Created by Osman Balci on 9/9/17.
//  Copyright © 2017 Osman Balci. All rights reserved.
//

import UIKit

class NowPlayingAnimation: NSObject {
    
    class func createNowPlayingAnimatedBarImages() -> [UIImage] {
        
        // Declare an array of UIImage objects to hold the "now playing" bar images to be animated
        var animatedBarImages = [UIImage]()
        
        /*
         -------------------------------------------------------------
         Create an array of bar images to be animated in the order of:
         AnimatedBarImages-0
         AnimatedBarImages-1
         AnimatedBarImages-2
         AnimatedBarImages-3
         AnimatedBarImages-2
         AnimatedBarImages-1
         -------------------------------------------------------------
         */
        
        for j in 0...3 {
            if let image = UIImage(named: "AnimatedBarImages-\(j)") {
                animatedBarImages.append(image)
            } else {
                print("AnimatedBarImages not found!")
            }
        }
        
        if let image = UIImage(named: "AnimatedBarImages-\(2)") {
            animatedBarImages.append(image)
        } else {
            print("AnimatedBarImages not found!")
        }
        
        if let image = UIImage(named: "AnimatedBarImages-\(1)") {
            animatedBarImages.append(image)
        } else {
            print("AnimatedBarImages not found!")
        }
        
        return animatedBarImages
    }
    
}


