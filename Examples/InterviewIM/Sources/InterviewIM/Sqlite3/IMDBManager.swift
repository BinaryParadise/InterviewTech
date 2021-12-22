//
//  IMDBManager.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/22.
//

import Foundation
import FMDB
import SQLite3
import CocoaLumberjackSwift

typealias QueryCompletion = ([[AnyHashable : Any]]?) -> Void

let pageSize = 20

class IMDBManager {
    static let shared = IMDBManager()
    let queue = DispatchQueue(label: "imdb.queue")
    private var dbQueue: FMDatabaseQueue!
    
    private init() {
        #if targetEnvironment(simulator)
        let dbPath = "\(ProcessInfo.processInfo.environment["SIMULATOR_HOST_HOME"]!)/db"
        #else
        let dbPath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)/db"
        #endif
        if !FileManager.default.fileExists(atPath: dbPath) {
            try? FileManager.default.createDirectory(atPath: dbPath, withIntermediateDirectories: true, attributes: nil)
        }
        dbQueue = FMDatabaseQueue(path: "\(dbPath)/iuim.db", flags: SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE)        
        setup()
    }
    
    /// 初始化数据库
    private func setup() {
        dbQueue.inDatabase { db in
            // 消息表
            db.executeStatements("""
CREATE TABLE IF NOT EXISTS "Messages" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "uid" INTEGER NOT NULL,
  "gid" INTEGER,
  "type" integer NOT NULL DEFAULT 0,
  "content" TEXT,
  "timestamp" real NOT NULL ON CONFLICT REPLACE DEFAULT (STRFTIME('%s', 'now')*1000 + SUBSTR(STRFTIME('%f', 'now'), 4))
);
""")
            // FTS4(content,id)
            db.executeStatements("CREATE VIRTUAL TABLE IF NOT EXISTS MessageFTS4 USING fts4(content TEXT, mid integer);")
            
            // 消息新增触发器
            db.executeStatements("""
CREATE TRIGGER IF NOT EXISTS "trigger_message_content"
AFTER INSERT
ON Messages
BEGIN
INSERT INTO MessageFTS4(content, mid) VALUES(new.content, new.id);
END;
""")
        }
        
        DDLogInfo("sqlite ver \(FMDatabase.fmdbUserVersion()) lib \(FMDatabase.sqliteLibVersion())")
    }
    
    func insert(sql: String, args: [Any]?) {
        dbQueue.inDatabase { db in
            try? db.executeUpdate(sql, values: args)
        }
    }
    
    func beginTransaction(block: (FMDatabase) -> Void) {
        dbQueue.inDatabase { db in
            db.beginTransaction()
            block(db)
            db.commit()
            db.close()
        }
    }
    
    func count() -> Int {
        var c: Int = 0
        dbQueue.inDatabase { db in
            if let rs = try? db.executeQuery("SELECT COUNT(1) FROM Messages", values: nil) {
                while rs.next() {
                    c = rs.long(forColumnIndex: 0)
                }
            }
        }
        return c
    }
    
    func query(pageNum: Int = 1, completion: QueryCompletion?) -> Void {
        queue.async {
            var results: [[AnyHashable : Any]] = []
            self.dbQueue.inDatabase { db in
                guard let rs = try? db.executeQuery("SELECT * FROM Messages limit ?, ?", values: [(pageNum - 1) * pageSize, pageNum * pageSize]) else { return }
                while rs.next() {
                    if let dict = rs.resultDictionary {
                        results.append(dict)
                    }
                }
            }
            completion?(results)
        }
    }
}
