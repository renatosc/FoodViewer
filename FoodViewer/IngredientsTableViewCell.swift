//
//  IngredientsTableViewCell.swift
//  FoodViewer
//
//  Created by arnaud on 01/02/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    var product: FoodProduct? = nil {
        didSet {
            if let ingredients = product?.ingredients {
                // TBD what about allergen ingredients?
                ingredientsLabel.text = ingredients
            }
            if let imageURL = product?.imageIngredientsSmallUrl {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                    do {
                        // This only works if you add a line to your Info.plist
                        // See http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http
                        //
                        let imageData = try NSData(contentsOfURL: imageURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                        if imageData.length > 0 {
                            // if we have the image data we can go back to the main thread
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                if imageURL == self.product!.imageIngredientsSmallUrl! {
                                    // set the received image
                                    self.ingredientsSmallImageView.image = UIImage(data: imageData)
                                }
                            })
                        }
                    }
                    catch {
                        print(error)
                    }
                })

            }
        }
    }

    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsSmallImageView: UIImageView!
    
}
