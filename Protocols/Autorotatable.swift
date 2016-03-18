//
//  Autorotatable.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import Foundation

enum Autorotation: Int {
    case Container
    case ContainerAndTopChildren
    case ContainerAndAllChildren
}

protocol Autorotatable {
    var autorotation: Autorotation { get set }
}
