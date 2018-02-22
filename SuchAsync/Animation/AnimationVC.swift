//
//  AnimationVC.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import AsyncDisplayKit

class AnimationVC: ASViewController<AnimationNode> {

    init() {
        super.init(node: AnimationNode())
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        node.form.expandButtonNode.addTarget(self, action: #selector(expand), forControlEvents: .touchUpInside)
    }

    @objc func expand() {
        node.form.toggleExpand()
    }
}
