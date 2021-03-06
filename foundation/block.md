# block

```
Block本质上也是一个oc对象，他内部也有一个isa指针。Block是封装了函数调用以及函数调用环境的OC对象。
Block也可以叫做闭包，简单来说就是一种带有局部变量的匿名函数，ARC中编译器自动完成从栈到堆的copy操作。
//示例
id (^blockName)(parameterTypes) = ^(parameters) {
  //statements
  return nil;
};
```

## 本质

```bash
xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int age = 10;
        void(^block)(int ,int) = ^(int a, int b){
            NSLog(@"this is block,a = %d,b = %d",a,b);
            NSLog(@"this is block,age = %d",age);
        };
        block(3,5);
    }
    return 0;
}
```



## 外部变量

### 默认情况

> 对于 block 外的变量引用，block 默认是将其复制到其数据结构中来实现访问的。也就是说block的自动变量截获只针对block内部使用的自动变量, 不使用则不截获, 因为截获的自动变量会存储于block的结构体内部, 会导致block体积变大。特别要注意的是默认情况下block只能访问不能修改局部变量的值。

### __block 修饰的外部变量

```objc
__block int val = 10;
//转换成
__Block_byref_val_0 val = {
    0,
    &val,
    0,
    sizeof(__Block_byref_val_0),
    10
};
```

会发现一个局部变量加上__block修饰符后竟然跟block一样变成了一个__Block_byref_val_0结构体类型的自动变量实例！！！！

此时我们在block内部访问val变量则需要通过一个叫__forwarding的成员变量来间接访问val变量(下面会对__forwarding进行详解)

## 不同修饰关键词的block属性存储对比

> 变量：表示内部访问了外部变量（局部变量、属性等等）
>
> - NSGlobalBlock：全局数据区
> - NSStackBlock：栈区（需要小心野指针）
> - NSMallocBlock: 堆区

|         | retain        | strong、copy  | retain+变量    | strong、copy+变量 |
| ------- | ------------- | ------------- | -------------- | ----------------- |
| **MRC** | NSGlobalBlock | NSGlobalBlock | `NSStackBlock` | NSMallocBlock     |
| **ARC** | NSGlobalBlock | NSGlobalBlock | NSMallocBlock  | NSMallocBlock     |

## 总结

- **在ARC环境下,编译器会自动把栈上的block copy到堆上**
- **所以说block的属性修饰符应该用`strong`或`copy`比较安全些。**
- **对block来说，属性修饰符用`strong`或`copy`效果是一样的。**