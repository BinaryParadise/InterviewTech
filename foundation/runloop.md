# RunLoop

> 是一种“闲”等待的循环，有事件的时候去寻找handler处理，没有事件时进入休眠。

下图中展现了 Runloop 在线程中的作用：从 input source 和 timer source 接受事件，然后在线程中处理事件。

![](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Multithreading/Art/runloop.jpg)



- 每个线程对应一个Runloop，App启动时主线程的RunLoop完成启动

### Input Source 和 Timer Source

其中 Input Source 又可以分为三类

    * Port-Based Sources，系统底层的 Port 事件，例如 CFSocketRef ，在应用层基本用不到

- Custom Input Sources，用户手动创建的 Source
- Cocoa Perform Selector Sources， Cocoa 提供的 performSelector 系列方法，也是一种事件源

Timer Source

   - 明显就是指计时器事件

### Runloop Observer

Runloop 通过监控 Source 来决定有没有任务要做，除此之外，我们还可以用 Runloop Observer 来监控 Runloop 本身的状态。 Runloop Observer 可以监控下面的 runloop 事件：

- 进入.
- 处理定时器.
- 处理输入源.
- 睡眠.
- 被唤醒处理事件之前.
- 退出.

### Runloop Mode

在监视与被监视中，Runloop 要处理的事情还挺复杂的。为了让 Runloop 能专心处理自己关心的那部分事情，引入了 Runloop Mode 概念。

![Runloop Mode](http://cc.cocimg.com/api/uploads/20150528/1432798883604537.png)

如图所示，Runloop Mode 实际上是 Source，Timer 和 Observer 的集合，不同的 Mode 把不同组的 Source，Timer 和 Observer 隔绝开来。Runloop 在某个时刻只能跑在一个 Mode 下，处理这一个 Mode 当中的 Source，Timer 和 Observer。

苹果文档中提到的 Mode 有五个，分别是：

- NSDefaultRunLoopMode
- ~~NSConnectionReplyMode~~
- ~~NSModalPanelRunLoopMode~~
- ~~NSEventTrackingRunLoopMode~~
- NSRunLoopCommonModes

iOS 中公开暴露出来的只有 NSDefaultRunLoopMode 和 NSRunLoopCommonModes。 NSRunLoopCommonModes 实际上是一个 Mode 的集合，默认包括 NSDefaultRunLoopMode 和 NSEventTrackingRunLoopMode。

### 与 Runloop 相关的坑

日常开发中，与 runLoop 接触得最近可能就是通过 NSTimer 了。一个 Timer 一次只能加入到一个 RunLoop 中。我们日常使用的时候，通常就是加入到当前的 runLoop 的 default mode 中，而 ScrollView 在用户滑动时，主线程 RunLoop 会转到 UITrackingRunLoopMode 。而这个时候， Timer 就不会运行。

有如下两种解决方案：

- 第一种: 设置 RunLoop Mode，例如 NSTimer,我们指定它运行于 NSRunLoopCommonModes ，这是一个 Mode 的集合。注册到这个 Mode 下后，无论当前 runLoop 运行哪个 mode ，事件都能得到执行。
- 第二种: 另一种解决 Timer 的方法是，我们在另外一个线程执行(需要手动调用`RunLoop.current.run()`)和处理 Timer 事件，然后在主线程更新 UI。