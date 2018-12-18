//
//  WheelViewController.swift
//  BestPractise
//
//  Created by songgeb on 2018/12/18.
//  Copyright © 2018 Songgeb. All rights reserved.
//

import UIKit

class WheelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupRollingView()
        // Do any additional setup after loading the view.
    }
    
    private func setupRollingView() {
        let titles = ["当灰烬查封了凝霜的屋檐", "当车菊草化作深秋的露水", "我用固执的枯藤做成行囊", "走向了那布满荆棘的他乡"]
        let rollingView = RollingView()
        rollingView.backgroundColor = .lightGray
        rollingView.titles = titles
        rollingView.rollingInterval = 2
        
        view.addSubview(rollingView)
        rollingView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["rollingView": rollingView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[rollingView]-100-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[rollingView(30)]", options: [], metrics: nil, views: views))
        
        rollingView.beginRolling()
    }

}
