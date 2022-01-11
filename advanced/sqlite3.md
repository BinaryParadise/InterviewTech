# sqlite3

`version: 3.30.1`

## 日志模式

```bash
# 查看
pragma journal_mode;
# 设置
pragma journal_model=wal;
```

| 模式     | 描述                                                   |
| :------- | :----------------------------------------------------- |
| DELETE   | 默认模式。在该模式下，在事务结束时，日志文件将被删除。 |
| TRUNCATE | 日志文件被截断为零字节长度。                           |
| PERSIST  | 日志文件被留在原地，但头部被重写，表明日志不再有效。   |
| MEMORY   | 日志记录保留在内存中，而不是磁盘上。                   |
| WAL      | 提高并发性能，支持单写多读。                           |
| OFF      | 不保留任何日志记录。                                   |

## 线程安全

`使用[FMDatabaseQueue inDatabase], 注意不要嵌套使用`

## 批量插入

| 方式         | 并发线程 | 耗时（秒） | 描述       |
| ------------ | -------- | ---------- | ---------- |
| 单条SQL插入  | 6        | 32.00      | 5000次x1条 |
| 批量SQL插入  | 6        | 0.36       | 25次x200条 |
| 事务批量插入 | 6        | 1.99       | 25次x200条 |

## 全文搜索FTS（Full-Text Search)