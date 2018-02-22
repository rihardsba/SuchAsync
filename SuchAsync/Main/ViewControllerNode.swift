//
//  ViewControllerNode.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import AsyncDisplayKit

class ViewControllerNode: ASDisplayNode {
    // Basic element initialization with an addition of static size setup

    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.cornerRadius = 15
        node.setAttributedTitle("Animation sample >".styled(with: .barButtonSelected), for: .normal)
        node.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        node.style.preferredSize = CGSize(width: 140, height: 50)
        return node
    }()

    let descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = "Sample of ASButtonNodes laid out in a ScrollNode with dynamic widths".styled(with: .descriptionText)
        return node
    }()

    let photoNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "ico-async-image")
        node.style.preferredSize = CGSize(width: 200, height: 100)
        return node
    }()

    let searchBarNode = ASDisplayNode.init(viewBlock: { () -> UIView in
        // We wanted to have a UISearchBar - it turns out it can be done like this
        return UISearchBar()
    })

    var searchBar: UISearchBar {
        // Force casting for delegacy and stuff
        return searchBarNode.view as! UISearchBar
    }

    // A subnode which utilizes its own subclass to perform layout
    let buttonBarNode = ButtonBarNode(buttons: ["One Button", "Another Button", "Just a Button",
                                                "Still a Button", "Doesnt matter, still Button",
                                                "Magic Button"].map { ActionButtonNode(title: $0) },
                                      verticalPadding: DeviceUtils.isIpad ? 4 : 8,
                                      buttonFont: UIFont.systemFont(ofSize: 12))

    override init() {
        super.init()
        // Just add the subnodes

        addSubnode(buttonNode)
        addSubnode(buttonBarNode)
        addSubnode(photoNode)
        addSubnode(descriptionNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // This is the scroll node subnode wrapped in a horizontal stack, which ensures, that it can have the content size necessary for horizontal scrolling

        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [buttonBarNode])
        stack.style.height = ASDimensionMake(60)
        stack.style.width = ASDimensionMake(constrainedSize.max.width)
        let stackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), child: stack)

        let buttonInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0), child: buttonNode)

        // wrapping top two elements to force them together
        let descriptionInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15), child: descriptionNode)
        let topStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .stretch, children: [descriptionInsets, stackInsets])

        // And every element is wrapped in a global vertical stack.
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [topStack, photoNode, buttonInsets])
    }
}
