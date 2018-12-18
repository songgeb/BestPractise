//
//  RollingView.swift
//  Test-Swift
//
//  Created by songgeb on 2018/12/17.
//  Copyright © 2018 Songgeb. All rights reserved.
//

import UIKit

/// 垂直方向滚动字幕
class RollingView: UIView {
    //public
    
    ///动态设置font
    public var titleFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            titleViews.forEach({ (label) in
                label.font = titleFont
            })
        }
    }
    /// 对齐方式
    public var alignment: NSTextAlignment = .center {
        didSet {
            titleViews.forEach { (label) in
                label.textAlignment = alignment
            }
        }
    }
    /// 截断模式
    public var lineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            titleViews.forEach { (label) in
                label.lineBreakMode = lineBreakMode
            }
        }
    }
    ///动态设置color属性
    public var titleColor = UIColor.black {
        didSet {
            titleViews.forEach({ (label) in
                label.textColor = titleColor
            })
        }
    }
    ///动态设置titlearray方法，仅在非滚动状态下起作用
    public var titles: [String]? {
        didSet {
            if isRolling {
                return
            }
            guard let titles = titles else {
                return
            }
            setup(titles: titles)
        }
    }
    ///滚动间隔时间(秒)，需要在beginRolling之前设置。默认1秒
    public var rollingInterval: TimeInterval = 1.0
    ///点击label回调处理
    public var clickHandler: ((_ index: Int) -> Void)?
    ///是否正在滚动
    public private(set) var isRolling = false
    ///开启滚动
    public func beginRolling() {
        if isRolling {
            return
        }
        
        if titleViews.count > 1 {
            addTimer()
            isRolling = true
        }
    }
    ///停止滚动
    public func stopRolling() {
        if !isRolling {
            return
        }
        removeTimer()
        isRolling = false
    }
    
    //private
    //scrollview贴近view
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private lazy var labelContainer: UIView = {
        return UIView()
    }()
    
    private var currentindex = 0
    private var timer: Timer?
    private var titleViews: [UILabel] = []
    //提供titlearray的初始化方法
    init(_ titles: [String] = []) {
        super.init(frame: .zero)
        self.titles = titles
        setup(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    private func setup(titles: [String]) {
        var titles = titles
        if titles.isEmpty {
            return
        }
        
        if titles.count > 1, let firstTitle = titles.first {
            titles.append(firstTitle)
        }
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["scrollView": scrollView, "container": labelContainer]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views))
        
        
        scrollView.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[container]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[container(==scrollView)]|", options: [], metrics: nil, views: views))
        
        titleViews.removeAll()
        var preView = labelContainer
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.font = titleFont
            label.textColor = titleColor
            label.text = title
            label.textAlignment = alignment
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            tap.numberOfTapsRequired = 1
            label.addGestureRecognizer(tap)
            titleViews.append(label)
            labelContainer.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let views = ["label": label]
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: [], metrics: nil, views: views))
            if index == 0 {
                NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0).isActive = true
               NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: labelContainer, attribute: .top, multiplier: 1, constant: 0).isActive = true
            } else {
               NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: preView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: preView, attribute: .height, multiplier: 1, constant: 0).isActive = true
            }
            
            if index == titles.count - 1 {
                NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: labelContainer, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            }
            
            preView = label
        }
    }
    
    private func addTimer() {
        if titleViews.count == 0 || titleViews.count == 1 {
            return
        }
        
        let timer = Timer.init(timeInterval: rollingInterval, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func labelTapped() {
        clickHandler?(currentindex)
    }
    
    @objc private func moveToNext() {
        let count = titleViews.count
        if count <= 1 {
            return
        }
        
        let scrollToindex = currentindex + 1
        defer {
            currentindex = scrollToindex % (titleViews.count - 1)
        }
        
        let currentOffset = CGFloat(currentindex) * scrollView.frame.height
        let nextOffset = CGFloat(scrollToindex) * scrollView.frame.height
    
        scrollView.contentOffset.y = currentOffset
        scrollView.setContentOffset(CGPoint(x: 0, y: nextOffset), animated: true)
    }
}
