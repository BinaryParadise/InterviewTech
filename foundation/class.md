
类在Objective-C中是objc_class结构体指针

## objc_class

```objc
// objc.h
typedef struct objc_class *Class;

struct objc_class {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;

#if !__OBJC2__
    Class _Nullable super_class                              OBJC2_UNAVAILABLE; //父类
    const char * _Nonnull name                               OBJC2_UNAVAILABLE; //类名
    long version                                             OBJC2_UNAVAILABLE; //版本信息, 默认为0
    long info                                                OBJC2_UNAVAILABLE; //信息, 运行时的一些标识
    long instance_size                                       OBJC2_UNAVAILABLE; //实例变量大小
    struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE; //成员变量链表
    struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;   //方法定义链表
    struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE; //方法缓存
    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE; //协议链表
#endif

} OBJC2_UNAVAILABLE;
```