//
//  AutomaticUITableView.swift
//  
//
//  Created by Rake Yang on 2021/12/24.
//

import Foundation
import UIKit
import MJRefresh

public enum RefreshState {
    case first
    case refresh
    case pullUp
}

/// 自动刷新（仿微信聊天下拉加载更多消息）
open class AutomaticUITableView: UITableView {
    var isRefreshing: Bool {
        return mj_header?.isRefreshing ?? false
    }
    
    open override var contentSize: CGSize {
        willSet {
            print("\(newValue)")
            //TODO: 无缝加载
            if !contentSize.equalTo(.zero) && !isRefreshing {
                //内容变多时且超过一屏自动增加偏移，不会回弹效果
                if contentSize.height > mj_h && newValue.height > contentSize.height {
                    //contentOffset.y += newValue.height - contentSize.height
                }
            }
        }
    }
}

/// 无缝刷新
public class RefreshSeamlessHeader: MJRefreshHeader {
    let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override var state: MJRefreshState {
        willSet {
            if newValue == .refreshing || newValue == .willRefresh {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        addSubview(indicator)
    }
    
    public override func placeSubviews() {
        mj_h = 30
        indicator.mj_x = (mj_w - indicator.mj_w)/2.0
        indicator.mj_y = (mj_h - 15)/2.0
    }
    
    public override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
    }
}
