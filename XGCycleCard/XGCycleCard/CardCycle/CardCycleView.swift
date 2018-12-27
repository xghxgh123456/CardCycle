//
//  CardCycleView.swift
//  XGCycleCard
//
//  Created by 雷振华 on 2018/12/26.
//  Copyright © 2018年 xgh. All rights reserved.
//

import UIKit

@objc protocol CardCycleViewDelegate{
    //样式
    func cardCycleItemView(index:Int) -> UIView;
    //尺寸
    @objc optional func cardCycleItemSize() -> CGSize;
    //点击
    @objc optional func cardCycleDidClick(index:Int);
    //滚动
    @objc optional func cardCycleDidScroll(index:Int);
}
class CardCycleView: UIView {
    let padding = 20 as CGFloat
    var delegate:CardCycleViewDelegate!
    var collectionView : UICollectionView!
    let groupCount = 100
    var indexs = [Int]()
    var datas: Array<Any>? {
        didSet{
            guard (datas?.count ?? 0)>0 else {
                return
            }
            self.initlizeData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = CyclicCardFlowLayout()
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(UINib.init(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:  "CardCollectionViewCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(self.collectionView)

    }
    
    func initlizeData()  {
        for _ in 0..<groupCount {
            for i in 0..<datas!.count{
                indexs.append(i)
            }
        }
        // 定位到 第50组(中间那组)
        collectionView.scrollToItem(at: NSIndexPath.init(item: groupCount / 2 * datas!.count, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CardCycleView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pointInView = self.convert(collectionView.center, to: collectionView)
        let indexPathNow = collectionView.indexPathForItem(at: pointInView)
        let index = indexs[(indexPathNow?.row)!]
        collectionView.scrollToItem(at: NSIndexPath.init(item: groupCount/2*datas!.count+index, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        self.delegate?.cardCycleDidScroll?(index: index)
        
    }

}
extension CardCycleView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indexs.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        let index = indexs[indexPath.row];
        if (self.delegate != nil) {
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let cellView = self.delegate .cardCycleItemView(index: index)
            cell.contentView.addSubview(cellView)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var size = CGSize(width: (SCREEN_WIDTH-padding*2)*0.5, height: self.frame.size.height)
        if self.delegate?.cardCycleItemSize?() != nil{
            size = self.delegate.cardCycleItemSize!()
        }
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexs[indexPath.row];
        self.delegate?.cardCycleDidClick?(index: index)
    }
}
