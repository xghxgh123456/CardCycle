//
//  ViewController.swift
//  XGCycleCard
//
//  Created by 雷振华 on 2018/12/24.
//  Copyright © 2018年 xgh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewd : CardCycleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewd = CardCycleView.init(frame: CGRect(x: 0, y: 300, width: SCREEN_WIDTH, height: 200))
        viewd.delegate = self
        viewd.datas = ["","","","",""]
        self.view.addSubview(viewd)
    }

}


extension ViewController:CardCycleViewDelegate{
   
    func cardCycleItemView(index: Int) -> UIView {
        let cardView = UIView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cardView.backgroundColor = UIColor.yellow
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = String(index)
        cardView.addSubview(label)
        return cardView
    }
    func cardCycleDidClick(index: Int) {
        print("点击了",index)
    }
    func cardCycleDidScroll(index: Int) {
        print("滚动到",index)
    }
}
