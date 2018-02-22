//
//  ViewController.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASViewController<ViewControllerNode> {

    init() {
        super.init(node: ViewControllerNode())
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()

        // because nodes like to hide under navigation bar
        edgesForExtendedLayout = []

        // Actions can be connected here
        node.buttonNode.addTarget(self, action: #selector(action), forControlEvents: .touchUpInside)

        // Same as delegacy, etc
        node.buttonBarNode.delegate = self
    }

    @objc func action() {
        showAnimationController()
    }

    private func showAnimationController() {
        let vc = AnimationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: ButtonBarNodeDelegate {
    func buttonBar(_ bar: ButtonBarNode, didSelectButtonAt index: Int) { }
}

