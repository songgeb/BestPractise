//
//  ImageTransparent.swift
//
//  Created by songgeb on 2018/7/31.
//  Copyright © 2018年 songgeb.meitu.test. All rights reserved.
//

import UIKit

extension UIImage {
    func sb_isTransparent() -> Bool {
        
        //创建只有alpha通道的context
        guard let cgImage = cgImage else {
            assertionFailure()
            return false
        }
        let width = cgImage.width
        let height = cgImage.height
        let data = UnsafeMutableRawPointer.allocate(byteCount: width * height, alignment: 1)
        let context = CGContext(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue)
        //将图片画到context上
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        //判断是否透明
        let ptr = data.bindMemory(to: UInt8.self, capacity: width * height)
        for i in 0..<(width * height) {
            let value = ptr[i]
            if value != 0 {
                return false
            }
        }
        //释放data
        data.deallocate()
        return true
    }
}
