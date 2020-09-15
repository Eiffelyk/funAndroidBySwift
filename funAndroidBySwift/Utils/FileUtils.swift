//
//  FileUtils.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/3.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation

class FileUtils {
    enum Err:Error {
        case sandboxNotFound
        case sys(Error)
    }
    @discardableResult
    class func write(data:Data?, to relativePath: String, dir:FileManager.SearchPathDirectory = .documentDirectory) -> (String?, Bool){
        guard let filePath = try? createDirIfNeed(path: relativePath) else { return (nil, false) }
        let success = FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        return (filePath, success)
    }
    @discardableResult
    class func readData(from relativePath: String, dir: FileManager.SearchPathDirectory = .documentDirectory) -> Data?{
        guard let rootPath = NSSearchPathForDirectoriesInDomains(dir, .userDomainMask, true).first
        else {
            return nil
        }
        let filePath = rootPath + relativePath
        return FileManager.default.contents(atPath: filePath)
    }
    
    class func createDirIfNeed(path relativePath: String, dir: FileManager.SearchPathDirectory = .documentDirectory) throws -> String {
        guard let rootPath = NSSearchPathForDirectoriesInDomains(dir, .userDomainMask, true).first
        else {
            throw Err.sandboxNotFound
        }
        let filePath = rootPath + relativePath
        if !FileManager.default.fileExists(atPath: filePath) {
            let dirNames = relativePath.split(separator: "/")
            if dirNames.count <= 1 {
                return filePath
            }
            let subDIrNames = dirNames[0 ..< dirNames.index(before: dirNames.endIndex)]
            var dirPath = subDIrNames.joined(separator: "/")
            if !dirPath.starts(with: "/") {
                dirPath += "/" + dirPath
            }
            dirPath = rootPath + dirPath
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        }
        return filePath
    }
}
