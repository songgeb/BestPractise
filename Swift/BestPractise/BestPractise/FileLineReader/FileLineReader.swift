import UIKit

//读取一定字节
//看下字节里有没有\n,如果有则取出一行，打印，并继续看有没有\n
//如果没有\n了，则保存好剩余部分，下次读取字节时，要拼到一起
class FileLineReader: NSObject, StreamDelegate {
  var inputStream: InputStream?
  var restData: Data?
  let fileURL: URL
  let delimiter = "\n".data(using: .utf8)!//换行符
  var lineNum = 0
  var lineBlock: ((Int, String) -> Void)?
  var completion: (() -> Void)?
  
  init(fileURL: URL) {
    self.fileURL = fileURL
  }
  
  func readLine(perLine: @escaping (Int, String) -> Void, completion: @escaping () -> Void) {
    if inputStream == nil {
      inputStream = InputStream(url: fileURL)
      if inputStream == nil {
        return
      }
      inputStream!.delegate = self
    }
    
    lineBlock = perLine
    self.completion = completion
    inputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
    inputStream?.open()
  }
  
  //MARK: - StreamDelegate
  func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
    switch eventCode {
    case .errorOccurred:
      print("error occurred!")
      fatalError()
    case .endEncountered:
      completion?()
      inputStream?.close()
      inputStream?.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
      inputStream = nil
      lineBlock = nil
      completion = nil
    case .hasBytesAvailable:
      let buff = UnsafeMutablePointer<UInt8>.allocate(capacity: 1024)
      buff.initialize(to: 0)
      let result = inputStream!.read(buff, maxLength: 1024)
      
      if result > 0 {
        var data = Data(buffer:UnsafeMutableBufferPointer(start: buff, count: result))
        if var tmp = restData {
          tmp.append(data)
          data = tmp
        }
        
        while(true) {
          let lineRange = data.range(of: delimiter)
          guard let range = lineRange else {
            restData = data;
            break
          }
          let lineData = data.subdata(in: Range(data.startIndex..<range.lowerBound))
          let str = String(data: lineData, encoding: .utf8)
          lineNum += 1
          lineBlock?(lineNum, str!)
          let restRange = Range(range.upperBound..<data.endIndex)
          data = data.subdata(in: restRange)
        }
      } else if result == 0 {
        //文档结束
        if let tmp = restData, tmp.count > 0 {
          let str = String(data: tmp, encoding: .utf8)
          lineNum += 1
          lineBlock?(lineNum, str!)
        }
      } else {
        print("read buffer error!")
        fatalError()
      }
    case .hasSpaceAvailable:fallthrough
    case .openCompleted: fallthrough
    default:
      break
    }
  }
}
