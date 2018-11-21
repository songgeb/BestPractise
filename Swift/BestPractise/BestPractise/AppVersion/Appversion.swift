//
//  Appversion.swift
//  BestPractise
//
//  Created by songgeb on 2018/9/28.
//  Copyright © 2018年 Songgeb. All rights reserved.
//

import UIKit

class Appversion {
    /// 为isNewVersionUser方法做数据准备
    ///
    /// - Parameter newVersionUserKey:
    private class func prepareDataForNewVersionUser (_ newVersionUserKey: String) {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return
        }
        let key = "com.newversionuser.appversionstorekey"
        let userDefaults = UserDefaults.standard
        let storedAppVersion = userDefaults.string(forKey: key)
        if let storedAppVersion = storedAppVersion {
            //当升级后第一次执行到这里时之前的版本和现在版本比较，当前版本大于之前版本，可以证明是升级用户
            if storedAppVersion < currentVersion {
                userDefaults.set(false, forKey: newVersionUserKey)
                userDefaults.synchronize()
            }
        } else {
            //新安装用户，第一次会执行到这里
            userDefaults.set(currentVersion, forKey: key)
            userDefaults.set(true, forKey: newVersionUserKey)
            userDefaults.synchronize()
        }
    }
    
    /// 是否为新版本用户，即新版本(当前版本)才安装的用户，且直到下版本升级之前该方法都返回true
    /// NOTE: 由于iOS不允许降级安装，所以该方法并不考虑该种情况
    /// - Returns: 是否为新版本用户
    class func isNewVersionUser() -> Bool {
        let newVersionUserKey = "com.newversionuser.storekey"
        prepareDataForNewVersionUser(newVersionUserKey)
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: newVersionUserKey)
    }
}
