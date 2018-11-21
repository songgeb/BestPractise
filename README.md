# BestPractise
iOS helper代码

### DynamicCellViewController
使用Autolayout实现动态`UICollectionViewCell`高度

理论部分参考[UICollectionViewFlowLayout下使用Autolayout实现动态cell高度](https://songgeb.github.io/2018/11/19/UICollectionViewFlowLayout%E4%B8%8B%E4%BD%BF%E7%94%A8Autolayout%E5%AE%9E%E7%8E%B0%E5%8A%A8%E6%80%81cell%E9%AB%98%E5%BA%A6/)

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


### sb_isTransparent

是`UIImage`的`Extension`，判断图片是否是全透明

### isNewVersionUser()

判断是否是新版本新安装的用户，而不是升级上来的用户。且从当前新安装app后，直到更新新版本该方法都返回true