# [详解](https://juejin.cn/post/6844903602545229831#heading-11)

## KVO

KVO全称Key-Value-Observing

### 使用

> 详见Demo

```swift
// 添加观察者
computer.addObserver(self, forKeyPath: "label", options: [.new, .old], context: nil)

// 移除观察者
computer.removeObserver(self, forKeyPath: "label")
```

### 常见崩溃原因

- KVO 添加次数和移除次数不匹配：
    - 移除了未注册的观察者，导致崩溃。
    - 重复移除多次，移除次数多于添加次数，导致崩溃。
    - 重复添加多次，虽然不会崩溃，但是发生改变时，也同时会被观察多次。
- 被观察者提前被释放，被观察者在 dealloc 时仍然注册着 KVO，导致崩溃（iOS 10及之前会崩溃）。`Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'An instance 0x7fdf4f69c320 of class Yunyun was deallocated while key value observers were still registered with it. Current observation info: <NSKeyValueObservationInfo 0x7fdf4f406520>`
- 添加了观察者，但未实现 observeValueForKeyPath:ofObject:change:context: 方法，导致崩溃。
- 添加或者移除时 keypath == nil，导致崩溃。

作者：ITCharge
链接：https://juejin.cn/post/6844903927469588488
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## KVC

KVC全称Key-Value-Coding