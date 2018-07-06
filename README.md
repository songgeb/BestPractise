# BestPractise
iOS helper代码

### FileLineReader

按行读文件，适合读取大文件，代码中有测试例子

1. 使用`InputStream`实现，因为`InputStream`读文件是异步方法，所以此处`readLine`方法也是异步方法，但block方法执行在主线程中
3. 由于2的原因，要在文件未读完之前要持有`reader`

```
fileLineReader = FileLineReader(fileURL: fileURL)
fileLineReader.readLine(perLine: { (lineNumber, content) in
  print("\(lineNumber),\(content)")
}, completion: {
  print("end")
})
```
### RemoveDup

文件内容去重

1. 去除文件中重复的行
2. 要求每个输入文件中的内容按行排列
3. 可同时传入多个文件, 当多个文件出现重复的内容时，重复内容仅会保留一份，且最终结果中，该重复的内容会仅保留在第一次出现该内容的文件中

