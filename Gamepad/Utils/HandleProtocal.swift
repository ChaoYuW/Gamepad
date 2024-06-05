//
//  HandleProtocal.swift
//  Gamepad
//
//  Created by 王二超 on 2024/6/3.
//

import Foundation

struct HandleProtocal{
    static let BLE_REQ_ID_OFFSET : UInt8 = 0
    static let BLE_RSP_ID_OFFSET : UInt8 = 100
    static let BLE_RSP_STATE_ID_OFFSET : UInt8 = 200
    static let BLE_REPORT_ID_OFFSET : UInt8 = 240
    
    // 分布发送每帧目标数据长度.
    static let BLE_RSP_DATA_LEN = 17
}

//enum BLE_REQ : UInt8{
//    
//}
