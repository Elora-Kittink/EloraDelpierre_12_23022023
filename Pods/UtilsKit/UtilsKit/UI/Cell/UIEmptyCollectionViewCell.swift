//
//  UIEmptyCollectionViewCell.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 10/07/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation
import UIKit

/**
 Default empty collection view cell
 */
public final class UIEmptyCollectionViewCell: UICollectionViewCell, ViewReusable {
    public static var nibName: String? = ""
    public static var identifier: String = "UIEmptyCollectionViewCell"
}
