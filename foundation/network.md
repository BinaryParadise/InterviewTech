# 网络



## 三次握手

> 所谓三次握手(Three-way Handshake)，是指建立一个 TCP 连接时，需要客户端和服务器总共发送3个包。
>
> 三次握手的目的是连接服务器指定端口，建立 TCP 连接，并同步连接双方的序列号和确认号，交换 TCP 窗口大小信息。在 socket 编程中，客户端执行 `connect()` 时。将触发三次握手。

[![](https://mermaid.ink/img/pako:eNptkMFKAzEQQH8lzLUR7DWwhdpdUJQ9mCIIuYTNVBc2SZtNpEvpXQQ_QPCiJ0HQo1-07W8YpS3d0tPMMG9eJrOAwioEBjXOApoC01LeOamFya1HYh_QkfbrffX4s_78pqvX5_bprX35YKQqa49GmF3zZDDo7fX5bZ70KeE4S-ZHZf8I4Vk-FmY3FyVdYOtoKBmOLv-qGPKgk3mvv6_tvkyuRzdpd7eD1U4PfU3Xd_TPGR8Pz64u-HmWAgWNTstSxdsthCFEgL9HjQJYTBVOZKi8AGGWEQ1TJT1mqvTWAZvIqkYKMnjLG1MA8y7gFtrcf0MtfwF-0K9A)](https://mermaid.live/edit/#pako:eNptkMFKAzEQQH8lzLUR7DWwhdpdUJQ9mCIIuYTNVBc2SZtNpEvpXQQ_QPCiJ0HQo1-07W8YpS3d0tPMMG9eJrOAwioEBjXOApoC01LeOamFya1HYh_QkfbrffX4s_78pqvX5_bprX35YKQqa49GmF3zZDDo7fX5bZ70KeE4S-ZHZf8I4Vk-FmY3FyVdYOtoKBmOLv-qGPKgk3mvv6_tvkyuRzdpd7eD1U4PfU3Xd_TPGR8Pz64u-HmWAgWNTstSxdsthCFEgL9HjQJYTBVOZKi8AGGWEQ1TJT1mqvTWAZvIqkYKMnjLG1MA8y7gFtrcf0MtfwF-0K9A)

### 第一次握手 SYN=1、ACK=0、SN=x 》SYN_SEND

客户端发送一个 TCP 的标志位置SYN=1 的包，指明客户端打算连接的服务器的端口，以及初始序号SN=X,保存在包头的序列号(Sequence Number)字段里。

发送完毕后，客户端进入 `SYN_SEND` 状态。

### 第二次握手 SYN=1、ACK=1，SN=y(ISN)、AN=x+1 》SYN_RCVD

服务器发回确认包(ACK)应答。即 SYN 标志位和 ACK 标志位均为1。服务器端选择自己 ISN 序列号，放到 Seq 域里，同时将确认序号(Acknowledgement Number)设置为客户的 ISN 加1，即X+1。 发送完毕后，服务器端进入 `SYN_RCVD` 状态。

### 第三次握手 SYN=0、ACK=1、AN=y+1 》ESTABLISHED

客户端再次发送确认包(ACK)，SYN 标志位为0，ACK 标志位为1，并且把服务器发来 ISN 的序号字段+1即y+1，放在确定字段中发送给对方，并且在数据段放写ISN的+1

发送完毕后，客户端进入 `ESTABLISHED` 状态，当服务器端接收到这个包时，也进入 `ESTABLISHED` 状态，TCP 握手结束。

![image](https://user-images.githubusercontent.com/8289395/70688626-2d3caf00-1ced-11ea-8e5b-5a98802a9e6f.png)

## 四次挥手

### 第一次挥手(FIN=1，seq=x)

假设客户端想要关闭连接，客户端发送一个 FIN 标志位置为1的包，表示自己已经没有数据可以发送了，但是仍然可以接受数据。

发送完毕后，客户端进入 `FIN_WAIT_1` 状态。

### 第二次挥手(ACK=1，ACKnum=x+1)

服务器端确认客户端的 FIN 包，发送一个确认包，表明自己接受到了客户端关闭连接的请求，但还没有准备好关闭连接。

发送完毕后，服务器端进入 `CLOSE_WAIT` 状态，客户端接收到这个确认包之后，进入 `FIN_WAIT_2` 状态，等待服务器端关闭连接。

### 第三次挥手(FIN=1，seq=y)

服务器端准备好关闭连接时，向客户端发送结束连接请求，FIN 置为1。

发送完毕后，服务器端进入 `LAST_ACK` 状态，等待来自客户端的最后一个ACK。

### 第四次挥手(ACK=1，ACKnum=y+1)

客户端接收到来自服务器端的关闭请求，发送一个确认包，并进入 `TIME_WAIT`状态，等待可能出现的要求重传的 ACK 包。

服务器端接收到这个确认包之后，关闭连接，进入 `CLOSED` 状态。

客户端等待了某个固定时间（两个最大段生命周期，2MSL，2 Maximum Segment Lifetime）之后，没有收到服务器端的 ACK ，认为服务器端已经正常关闭连接，于是自己也关闭连接，进入 `CLOSED` 状态。
