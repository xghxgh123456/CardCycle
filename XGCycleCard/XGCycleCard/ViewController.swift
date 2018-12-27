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
    let datas = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewd = CardCycleView.init(frame: CGRect(x: 0, y: 300, width: SCREEN_WIDTH, height: 200))
        viewd.delegate = self
        self.view.addSubview(viewd)
        viewd.reloadData()
    }

}


extension ViewController:CardCycleViewDelegate{
    func cardCycleItems() -> Array<Any> {
        return self.datas
    }
   // 自定义视图
    func cardCycleItemView(index: Int) -> UIView {
        let cardView = UIView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cardView.backgroundColor = UIColor.yellow
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = String(index)
        cardView.addSubview(label)
        return cardView
    }
    //视图大小 不实现则默认
    func cardCycleItemSize() -> CGSize {
        return CGSize(width: 200, height: 100)
    }
    func cardCycleDidClick(index: Int) {
        print("点击了",index)
    }
    func cardCycleDidScroll(index: Int) {
        print("滚动到",index)
    }
}
