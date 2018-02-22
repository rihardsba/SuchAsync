//
//  ButtonBar.swift
//  Gensler
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import BonMot

protocol ButtonBarNodeDelegate: class {
    func buttonBar(_ bar: ButtonBarNode, didSelectButtonAt index: Int)
}

class ActionButtonNode: ASButtonNode {

    init(title: String) {
        super.init()
        setAttributedTitle(title.styled(with: .barButtonDefault), for: .normal)
        setAttributedTitle(title.styled(with: .barButtonSelected), for: .selected)
    }

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.lightGray.withAlphaComponent(0.6) : .clear
        }
    }
}

class ButtonBarNode: ASScrollNode {

    weak var delegate: ButtonBarNodeDelegate?

    var buttons: [ASButtonNode]
    var verticalPadding: CGFloat = 5
    var buttonFont: UIFont

    init(buttons: [ASButtonNode], verticalPadding: CGFloat, buttonFont: UIFont) {
        self.buttons = buttons
        self.buttonFont = buttonFont
        self.verticalPadding = verticalPadding

        super.init()

        scrollableDirections = [.left, .right]
        automaticallyManagesContentSize = true
        automaticallyManagesSubnodes = true

        buttons.forEach {
            addSubnode($0)
            $0.cornerRadius = DeviceUtils.isIpad ? 22 : 14

            $0.addTarget(self, action: #selector(didSelect(button:)), forControlEvents: .touchUpInside)
        }
        buttons[0].isSelected = true
    }

    func buttonAt(index: Int) -> ASButtonNode? {
        return buttons[safe: index]
    }

    @objc func didSelect(button: ASButtonNode) {
        buttons.forEach {
            $0.isSelected = button == $0
        }

        if let idx = buttons.index(of: button) {
            delegate?.buttonBar(self, didSelectButtonAt: idx)
        }
    }

    func selectButtonAt(idx: Int) {
        guard let button = buttonAt(index: idx) else { return }
        didSelect(button: button)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        buttons.forEach {
            let expectedHeight = constrainedSize.max.height - 2 * verticalPadding
            let title = $0.titleNode.attributedText?.string
            let expectedWidth = title?.width(withConstraintedHeight: expectedHeight, font: buttonFont) ?? 0

            $0.style.preferredSize = CGSize(width: expectedWidth + (DeviceUtils.isIpad ? 35 : 25), height: expectedHeight)
        }

        let hStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceAround, alignItems: .center, children: buttons)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: verticalPadding, left: DeviceUtils.isIpad ? 24 : 8, bottom: verticalPadding, right: DeviceUtils.isIpad ? 24 : 8), child: hStack)
    }
}
