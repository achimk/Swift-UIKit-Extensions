//
//  UIImage+Color.swift
//
//  Created by Joachim Kret on 18/03/16.
//  Copyright © 2016 Joachim Kret. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(color: UIColor, size: CGSize = CGSizeMake(1.0, 1.0)) -> UIImage {
        assert(size.width > 0.0 && size.height > 0.0)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
    
    class func image(color: UIColor, border: UIColor, insets: UIEdgeInsets = UIEdgeInsetsZero, size: CGSize = CGSizeMake(1.0, 1.0)) -> UIImage {
        assert(size.width > 0.0 && size.height > 0.0)
        var rect = CGRect(origin: CGPoint.zero, size: size)
        
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, border.CGColor);
        CGContextFillRect(context, rect);
        
        rect = UIEdgeInsetsInsetRect(rect, insets);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
}
