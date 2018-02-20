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
        node.setAttributedTitle("Button".styled(with: .barButtonSelected), for: .normal)
        node.backgroundColor = .black
        node.style.preferredSize = CGSize(width: 100, height: 50)
        return node
    }()

    let photoNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "asynckit.png")
        node.style.preferredSize = CGSize(width: 200, height: 100)
        return node
    }()

    let searchBarNode = ASDisplayNode.init(viewBlock: { () -> UIView in
        // We wanted to have a UISearchBar - it turns out it can be done like this
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.tintColor = .black
        bar.backgroundColor = .white
        bar.placeholder = "Search"
        return bar
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
        addSubnode(searchBarNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // And perform layout.

        // This is the scroll node subnode wrapped in a horizontal stack, which ensures, that it can have the content size necessary for horizontal scrolling

        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [buttonBarNode])
        stack.style.height = ASDimensionMake(60)
        stack.style.width = ASDimensionMake(constrainedSize.max.width)
        let stackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), child: stack)

        // Nothing wrong with settings height/width/both here as well.
        searchBarNode.style.height = ASDimensionMake(44)
        let barInsets = ASInsetLayoutSpec(insets: .zero, child: searchBarNode)

        // The first two elements wrapped in a stack to have them act as a group when performing layout.
        let barStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [stackInsets, barInsets])

        let buttonInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0), child: buttonNode)

        // And every element is wrapped in a global vertical stack.
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [barStack, photoNode, buttonInsets])
    }
}
