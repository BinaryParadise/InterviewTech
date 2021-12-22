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

class IMDBManager {
    static let shared = IMDBManager()
    
    private var dbQueue: FMDatabaseQueue!
    
    init() {
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
    
    func query(pageNum: Int = 1) -> [[AnyHashable : Any]] {
        var results: [[AnyHashable : Any]] = []
        dbQueue.inDatabase { db in
            guard let rs = try? db.executeQuery("SELECT * FROM Messages limit ?, ?", values: [(pageNum - 1) * 20, pageNum * 20]) else { return }
            while rs.next() {
                if let dict = rs.resultDictionary {
                    results.append(dict)
                }
            }
        }
        return results
    }
}
