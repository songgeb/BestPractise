//
//  RemoveDup.swift
//  Test-Swift
//
//  Created by songgeb on 2018/7/6.
//

import UIKit

//去除文件中重复的行
//要求每个输入文件中的内容按行排列
//可同时传入多个文件, 当多个文件出现重复的内容时，重复内容仅会保留一份，且最终结果中，该重复的内容会仅保留在第一次出现该内容的文件中
class RemoveDup: NSObject {
  private var files: [URL]
  private var reader: SBReader?
  private var currentDataSet: Set<String>
  
  init(files: [URL]) {
    self.files = files
    self.currentDataSet = Set<String>()
  }

  func start() {
    if files.count == 0 {
      //任务完成
      print("任务结束!")
      return
    }
    var tmpDataSet = Set<String>()
    var fileURL = files.first!
    print("开始任务列表, \(fileURL.lastPathComponent)")
    reader = SBReader(fileURL: fileURL)
    reader?.readLine(perLine: { (col, content) in
      tmpDataSet.insert(content)
    }, completion: {
      //做减法
      //潜在的自己文件也能过滤一把
      let resultDataSet = tmpDataSet.subtracting(self.currentDataSet)
      print("当前文件共\(tmpDataSet.count)行, 减法后剩余\(resultDataSet.count)")
      //写入随机的文件
      fileURL.appendPathExtension("new")
      self.writeSetToFile(url: fileURL, set: resultDataSet)
      //更新currentDataSet
      self.currentDataSet = tmpDataSet.union(self.currentDataSet)
      //继续下个文件
      self.files.removeFirst()
      self.start()
    })
  }
  
  func writeSetToFile(url: URL, set: Set<String>) {
    //文件没有，则创建
    let filemanager = FileManager.default
    if filemanager.fileExists(atPath: url.path) {
      try! filemanager.removeItem(at: url)
    }
    filemanager.createFile(atPath: url.path, contents: nil, attributes: nil)
    
    let fileHandler = try! FileHandle(forWritingTo: url)
    for line in set {
      fileHandler.write((line+"\n").data(using: .utf8)!)
    }
    fileHandler.closeFile()
    print("文件写入结束-->\(url)")
  }
}
