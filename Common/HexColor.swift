//
//  Color.swift
//
//  Created by Joachim Kret on 18/03/16.
//  Copyright © 2016 Joachim Kret. All rights reserved.
//

import UIKit

class HexColor: UIColor, IntegerLiteralConvertible {
    convenience required init(integerLiteral value: Int) {
        let r = (value >> 16) & 0xff
        let g = (value >> 8) & 0xff
        let b = value & 0xff
        let a = (value >> 24) & 0xff
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(a) / 255.0)
    }
}

enum BaseColor: HexColor {
    case Black  = 0xff000000
    case Red    = 0xffff0000
    case Green  = 0xff00ff00
    case Blue   = 0xff0000ff
    case White  = 0xffffffff
}

enum FlatColor: HexColor {
    case Turquoise      = 0xff1abc9c
    case GreenSea       = 0xff16a085
    case Emerald        = 0xff2ecc71
    case Nephritis      = 0xff27ae60
    case PeterRiver     = 0xff3498db
    case BelizeHole     = 0xff2980b9
    case Amethyst       = 0xff9b59b6
    case Wisteria       = 0xff8e44ad
    case WetAsphalt     = 0xff34495e
    case MidnightBlue   = 0xff2c3e50
    case Concrete       = 0xff95a5a6
    case Asbestos       = 0xff7f8c8d
    case Clouds         = 0xffecf0f1
    case Silver         = 0xffbdc3c7
    case Alizarin       = 0xffe74c3c
    case Pomegranate    = 0xffc0392b
    case Carrot         = 0xffe67e22
    case Pumpkin        = 0xffd35400
    case SunFlower      = 0xfff1c40f
    case Orange         = 0xfff39c12
}