//
//  Help.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import UIKit
import Device
import BonMot

class DeviceUtils {
    // Simple code one-liners to differentiate between custom iPad/iPhone layouts, when necessary
    static var isIpad: Bool {
        return Device.size() >= .screen7_9Inch
    }
}

extension String {
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension StringStyle {
    // Bonmot extensions have been providing extremely useful when dealing with a bunch of differently styled strings.
    static var barButtonSelected: StringStyle {
        return StringStyle(
            .font(UIFont.systemFont(ofSize: 12)),
            .color(.white)
        )
    }
    static var barButtonDefault: StringStyle {
        return StringStyle(
            .font(UIFont.systemFont(ofSize: 12)),
            .color(.black)
        )
    }

    static var titleText: StringStyle {
        return StringStyle(
            .alignment(.center),
            .font(UIFont.boldSystemFont(ofSize: 24)),
            .color(.black)
        )
    }

    static var subtitleText: StringStyle {
        return StringStyle(
            .alignment(.center),
            .font(UIFont.systemFont(ofSize: 18)),
            .color(.black)
        )
    }

    static var descriptionText: StringStyle {
        return StringStyle(
            .alignment(.center),
            .font(UIFont.systemFont(ofSize: 14)),
            .color(.black)
        )
    }
}

extension Collection {
    // Small extension that performs safe indexing on collections
    public subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

