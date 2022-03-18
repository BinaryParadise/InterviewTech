# Flutter

[Demo](https://github.com/BinaryParadise/FlutterDemo)

## 基础知识

### 与其它跨平台的区别

`flutter`重写了一整套包括底层渲染逻辑和上层开发语言的完整解决方案;这样不仅可以保证视图渲染在Android和iOS上的高度一致性，在代码执行效率和渲染性能上也可以匹配原生App的体验。

### 热重载原理

flutter热重载主要继续State, 也就是常用setState方法，修改属性后会执行相应的build方法

源码: `/usr/local/flutter/packages/flutter_tools/lib/src/run_hot.dart`

### Widget、Element、RenderObject

- Widget是用户界面的一部分，并且是不可变的。
- Element是在树中特定位置的实例。
- RenderObject是渲染树中的一个对象，它的层次结构是渲染库的核心。

### isolate通信原理

isolate线程之间的通信主要通过port异步消息传来进行
实例化过程: 
    - 示例化isolate结构体
    - 在堆中分配线程内存
    - 配置port等过程