//
//  HTTimerLeakAvoider.swift
//  WuKongKit
//
//  Created by weitu on 2024/11/22.
//

import Foundation

class HTTimerLeakAvoider: NSObject {
    
    private var timer: Timer!
    
    var timerHandler: (() -> Void)?
    
    init(timeInterval: Double, repeats: Bool = true) {
        super.init()
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(timerHappen), userInfo: nil, repeats: true)
    }
    
    func start() {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func invalidate() {
        timer.invalidate()
        timer = nil
    }
    
    @objc func timerHappen() {
        timerHandler?()
    }
    
    deinit {
        print("\(type(of: self))-deinit")
    }
}
