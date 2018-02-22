//
//  FormNode.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 21/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import AsyncDisplayKit

class FormNode: ASDisplayNode {
    var expanded = false {
        didSet {
            transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        }
    }

    let titleNode: ASTextNode = {
        let node = ASTextNode()
        node.borderColor = UIColor.black.cgColor
        node.borderWidth = 1
        node.cornerRadius = 12
        node.attributedText = "Title Text".styled(with: .titleText)
        return node
    }()

    let expandButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(#imageLiteral(resourceName: "ico-chevron-expand"), for: .normal)
        return node
    }()

    let imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "ico-async-image")
        return node
    }()

    let descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = "This is a description text, which is supposed to take up all of the available space in this area".styled(with: .descriptionText)
        return node
    }()

    let actionButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .lightGray
        node.setAttributedTitle("Some button".styled(with: .barButtonDefault), for: .normal)
        return node
    }()

    override init() {
        super.init()

        borderColor = UIColor.black.cgColor
        borderWidth = 1
        cornerRadius = 5

        backgroundColor = .white

        addSubnode(titleNode)
        addSubnode(imageNode)
        addSubnode(expandButtonNode)
        addSubnode(actionButtonNode)
        addSubnode(descriptionNode)

        toggleAnimation()
    }



    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        // Default animation scenario is in place, but overriding this function allows to implement custom animations
        // The animation can definitely be improved to perform smoother, but its just an overall sample
        super.animateLayoutTransition(context)
    }

    func toggleExpand() {
        expanded = !expanded
        toggleAnimation()
    }

    func toggleAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation.x")
        anim.isRemovedOnCompletion = false
        anim.isAdditive = true
        anim.fillMode = kCAFillModeForwards
        anim.toValue = Double.pi
        anim.duration = 0.5

        expandButtonNode.layer.add(anim, forKey: nil)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 44, height: 44)

        titleNode.style.height = ASDimensionMake(32)
        let titleStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .stretch, children: [titleNode])
        titleStack.style.flexGrow = 1.0

        expandButtonNode.style.height = ASDimensionMake(32)

        let formStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .center, alignItems: .stretch, children: [imageNode, titleStack])

        actionButtonNode.style.height = ASDimensionMake(expanded ? 44 : 0)
        descriptionNode.style.height = ASDimensionMake(expanded ? 90 : 0)

        let descriptionInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 49, bottom: 0, right: 0), child: descriptionNode)

        let globalChildren: [ASLayoutElement] = [formStack, descriptionInsets, actionButtonNode, expandButtonNode]
        let globalStack = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .center, alignItems: .stretch, children: globalChildren)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), child: globalStack)
    }
}
