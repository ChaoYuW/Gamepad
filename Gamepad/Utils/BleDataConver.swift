//
//  BleDataConver.swift
//  Gamepad
//
//  Created by 王二超 on 2024/6/3.
//

import UIKit

import UIKit

class BleDataConver: NSObject {
    // 将十进制转换为十六进制字符串
    func decimalToHexString(_ decimal: Int) -> String {
        
        let hexString = String(decimal, radix: 16, uppercase: true)
        
        return hexString.count == 1 ? "0" + hexString : hexString
    }
    
    // 将16进制字符串转换为Data
    func dataFromHexString(_ hexString: String) -> Data? {
        var hex = hexString
        var data = Data()

        while hex.count > 0 {
            let index = hex.index(hex.startIndex, offsetBy: 2)
            let byte = String(hex[..<index])
            hex = String(hex[index...])

            if var num = UInt8(byte, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }

        return data
    }
}
