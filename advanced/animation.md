## 背景

动画主要由QuartzCore.CoreAnimation提供支持，CALayer负责呈现视觉内容，CATransaction负则CALayer修改的捕获和提交。

**动画需要3个基本要素：内容、时间和变化规律**

## CAAnimation

这个是基类，所以它不会有特别有特色的属性，而是一些通用性的东西。在属性里值得注意的是`timingFunction`和`delegate`。`timingFunction`提供了时间的变化函数，可以理解成时间流速变快或变慢。`delegate`就两个方法，通知你动画开始了和结束了，没什么特别的。

#### CAMediaTiming

这是一个协议，`CAAnimation`实现了这个协议，里面有一些跟时间相关的属性：

- duration 动画时间
- repeatCount 重复次数
- autoreverses 自动反转动画，如一个动画是从A到B，这个为true时，会接着执行从B再到A的动画。



## AutoAayout

- 使用updateConstraints的检索条件`LayoutConstraint.swift`

  ```swift
  // SnapKit 
  internal func ==(lhs: LayoutConstraint, rhs: LayoutConstraint) -> Bool {
      guard lhs.firstItem === rhs.firstItem &&
            lhs.secondItem === rhs.secondItem &&
            lhs.firstAttribute == rhs.firstAttribute &&
            lhs.secondAttribute == rhs.secondAttribute &&
            lhs.relation == rhs.relation &&
            lhs.priority == rhs.priority &&
            lhs.multiplier == rhs.multiplier else {
          return false
      }
      return true
  }
  ```

- 保存约束，在需要动画时先停用再makeConstraints

  ```swift
  UIView.animate(withDuration: 0.25) {
    // 停用约束
    self.indicatorConstraint.deactivate()
    // 更新约束
    self.indicator.snp.makeConstraints { make in
        self.indicatorConstraint = make.centerX.equalTo(newBtn).constraint
    }
    // 布局约束
    self.indicator.superview?.layoutIfNeeded()
  }
  ```
  
  
  
  