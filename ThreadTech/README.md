# ThreadTech

A description of this package.

## GCD

### 任务：串行队列

| 当前队列 | async | sync |
| ---- | ---- | ---- |
| 串行队列 | 新线程x1 一 顺序执行 | 目标线程 一 顺序执行 |
| 并行队列 | 新线程x1 一 顺序执行 | 新线程x1 一 顺序执行 |
| 全局队列 | 新线程x1 一 顺序执行 | 新线程x1 一 顺序执行 |
| 主队列 | 新线程x1 一 顺序执行 | 主线程 一 顺序执行 |

### 任务：并行队列

| 当前队列 | async                | sync                 |
| -------- | -------------------- | -------------------- |
| 串行队列 | 新线程xN 一 同时执行 | 目标线程 一 顺序执行 |
| 并行队列 | 新线程xN 一 同时执行 | 新线程x1 一 顺序执行 |
| 全局队列 | 新线程xN 一 同时执行 | 新线程x1 一 顺序执行 |
| 主队列   | 新线程xN 一 同时执行 | 主线程 一 顺序执行   |

### 任务：全局队列

| 当前队列 | async                | sync                 |
| -------- | -------------------- | -------------------- |
| 串行队列 | 新线程xN 一 同时执行 | 目标线程 一 顺序执行 |
| 并行队列 | 新线程xN 一 同时执行 | 新线程x1 一 顺序执行 |
| 全局队列 | 新线程xN 一 同时执行 | 新线程x1 一 顺序执行 |
| 主队列   | 新线程xN 一 同时执行 | 主线程 一 顺序执行   |

### 任务：主队列

| 当前队列 | async              | sync               |
| -------- | ------------------ | ------------------ |
| 串行队列 | 主线程 一 顺序执行 | 主线程 一 顺序执行 |
| 并行队列 | 主线程 一 顺序执行 | 主线程 一 顺序执行 |
| 全局队列 | 主线程 一 顺序执行 | 主线程 一 顺序执行 |
| 主队列   | 主线程 一 顺序执行 | DeadLock           |



## NSThread