//
//  ImagesPageTableViewCell.swift
//  FoodViewer
//
//  Created by arnaud on 21/08/2017.
//  Copyright © 2017 Hovering Above. All rights reserved.
//

import UIKit

class ImagesPageTableViewCell: UITableViewCell {

    fileprivate struct Constants {
        static let CellContentViewMargin = CGFloat(8)
    }
        
    var productImage : UIImage? = nil {
        didSet {
            if let newImage = productImage {
                // print("\(brandLabel): product image size \(newImage.size)")
                // what to do if the image is wider than the contentView area of the cell's contentView?
                let widthScale = (newImage.size.width) / (self.contentView.frame.size.width - Constants.CellContentViewMargin * 2)
                // the height may not be larger than the width of the frame
                let heightScale =  (newImage.size.height) / (self.contentView.frame.size.width - Constants.CellContentViewMargin * 2)
                if (widthScale > 1) || (heightScale > 1) {
                    if widthScale > heightScale {
                        // width is the determining factor
                        let newSize = CGSize(width: newImage.size.width / widthScale, height: newImage.size.height / widthScale)
                        let scaledImage = newImage.imageResize(newSize)
                            productImageView.image = scaledImage
                    } else {
                        // height is the determining factor
                        let newSize = CGSize(width: newImage.size.width / heightScale, height: newImage.size.height / heightScale)
                        let scaledImage = newImage.imageResize(newSize)
                            productImageView.image = scaledImage
                    }
                } else {
                    productImageView?.image = newImage
                }
                // still need to solved what happens when the image is very high
                    
                productImageView.contentMode = .center
                    
                // print("product imageView size \(productImageView?.bounds.size)")
                // print("cell: \(self.contentView.bounds.size)")
                /*productImageView.image = newImage.squareCropImageToSideLength(productImageView) */
            } else {
                productImageView.image = UIImage(named: "NoImage")
            }
        }
    }
        
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.image = productImage
        }
    }
    
}

