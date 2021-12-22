# 常见问题解决方案

## 时间同步

```swift
public extension Date {
    /// App启动时是否校准
    static var proofOnLaunch = true
    static func serveDate() -> Self {
        // 服务器时间戳
        let serverTime = UserDefaults.standard.double(forKey: "ServeTimestamp");
        // 同步时设备启动已启动时间（秒）
        let bootInterval = UserDefaults.standard.double(forKey: "BootTimeInterval")
        if serverTime == 0 || bootTimeInterval() < bootInterval || proofOnLaunch {
            // 尚未同步或者设备已重启时同步一次
            let t1 = bootTimeInterval()
            //TODO: 处理请求的时间消耗导致的误差
            URLSession.shared.dataTask(with: URL(string: "http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp")!) { data, response, error in
                guard let data = data else {
                    return
                }
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary, let t = jsonObj.value(forKeyPath: "data.t") as? String {
                    let timestamp = Double(t)! / 1000.0
                    proofOnLaunch = false
                    print("时间同步成功 \(Date(timeIntervalSince1970: (timestamp))), 设备启动时间：\(String(format: "%.2f", bootTimeInterval())) (秒)")
                    print("请求耗时: \(bootTimeInterval() - t1)")
                    UserDefaults.standard.set(bootTimeInterval(), forKey: "BootTimeInterval")
                    UserDefaults.standard.set(timestamp, forKey: "ServeTimestamp")
                }
            }.resume()
        }
        if serverTime == 0 {//未同步暂用本地时间代替
            return Date()
        }
        let curTnterval = bootTimeInterval() - bootInterval
        return Date(timeIntervalSince1970: serverTime + curTnterval)
    }
}

/// 获取设备已启动时间（秒），设备重启会重置为0
func bootTimeInterval() -> TimeInterval {
    var boottime: timeval = timeval()
    var mib = [CTL_KERN, KERN_BOOTTIME]
    var size = MemoryLayout<timeval>.size
    sysctl(&mib, 2, &boottime, &size, nil, 0)
    //受系统时间影响
    return Date().timeIntervalSince1970 - (CGFloat(boottime.tv_sec) + Double(boottime.tv_usec)/1000000.0)
}
```

