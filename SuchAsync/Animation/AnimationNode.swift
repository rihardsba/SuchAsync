//
//  AnimationNode.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import AsyncDisplayKit

class AnimationNode: ASDisplayNode {
    let form = FormNode()

    override init() {
        super.init()
        backgroundColor = .white
        addSubnode(form)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [form])
    }
}
