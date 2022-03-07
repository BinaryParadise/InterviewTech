# 编译原理

[详细说明](https://juejin.cn/post/6844904197045878791)

[实践-自定义Clang插件](https://docs.wildlotus.shop/objective-c/compile)

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/6/22/172db10ca757ff17~tplv-t2oaga2asx-watermark.awebp)

## 编译前端

输入: **.m**文件

输出: **IR**

* 预处理器
* 词法分析→token
* 语法分析→ast
* CodeGen→IR



## 编译后端

输入: **IR**

输出: **Mach-O**

* LLVM Optimization
* 生成汇编→.o
* 链接→Mach-O