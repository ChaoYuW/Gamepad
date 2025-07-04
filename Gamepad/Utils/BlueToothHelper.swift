//
//  BlueToothHelper.swift
//  Gamepad
//
//  Created by chao on 2024/6/3.
//

//https://blog.csdn.net/weixin_43899955/article/details/134067199
import UIKit
import CoreBluetooth

enum BleState: Int {
    case ready
    case scanning
    case connecting
    case connected
}

///传出蓝牙当前连接的设备发送过来的信息
typealias BleDataBlock = (_ data: Data) -> Void
///传出蓝牙当前搜索到的设备信息
typealias BlePeripheralsBlock = (_ pArray: [CBPeripheral]) -> Void
//当设备连接成功时，记录该设备，用于请求设备版本号
typealias BleConnectedBlock = (_ peripheral: CBPeripheral, _ characteristic:CBCharacteristic) -> Void

class BlueToothHelper: NSObject {
    private let BLE_WRITE_UUID = "xxxx"
    private let BLE_NOTIFY_UUID = "11C8B310-80E4-4276-AFC0-F81590B2177F"
    
    static let shared = BlueToothHelper()
    
    var bleState:BleState = .ready
    
    //传出扫描到的设备
    var backPeripheralsBlock:BlePeripheralsBlock?
    ///传出当前连接成功的设备
    var backConnectedBlock:BleConnectedBlock?
    //传出数据
    var backDataBlock: BleDataBlock?
    
    var centralManager:CBCentralManager?
    ///扫描到的所有设备
    var aPeArray:[CBPeripheral] = []
    //当前连接的设备
    var peripheral:CBPeripheral?
    var writeCh: CBCharacteristic?
    var notifyCh: CBCharacteristic?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey:true])
    }
    
    //MARK: - Public Method
    
    ///保存当前选中的设备
    func setSelectedPeripherals(peripheral:CBPeripheral) {
        self.peripheral = peripheral
    }
    
    //主动获取搜索到的peripheral列表
    func getPeripheralList() -> [CBPeripheral] {
        return aPeArray
    }
    
    //MARK: - Private Method
    ///开始扫描
    func startScan(serviceUUIDS:[CBUUID]? = nil, options:[String: Any]? = nil) {
        aPeArray = []
        
        // 1 判断蓝牙是否可用
        bleState = .scanning
// - 第一步 扫描外设 scanForPeripherals
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    ///停止扫描
    func stopScan() {
        centralManager?.stopScan()
    }
    //连接指定的设备
    func doConnect(peripheral:CBPeripheral) {
        bleState = .connecting
        centralManager?.connect(peripheral, options: nil)
        peripheral.delegate = self
    }
    ///断开连接
    func disconnect(peripheral: CBPeripheral) {
        centralManager?.cancelPeripheralConnection(peripheral)
    }

    
    func sendData(data:GamePadState){
        //
        let gamepadState = GamePadState()
        gamepadState.back = true
        
        let report = GamePadReport()
        report.setValue(s: data)
        
        let data = Data(bytes: report.gamePadData, count: report.gamePadData.count)
        
        
        
        peripheral?.writeValue(data, for: self.notifyCh!, type: .withResponse)
    }
    
    func intArrayToData(_ intArray: [Int8]) -> Data {
        // 假设所有的 Int 都是 32 位（Int32）
        let int32Array = intArray.map { Int8($0) } // 如果不是 Int32，这里可能会有问题

        let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: int32Array.count)
        defer { buffer.deallocate() } // 确保释放内存

        buffer.initialize(from: int32Array, count: int32Array.count)

        let data = Data(bytes: buffer, count: MemoryLayout<Int32>.size * int32Array.count)
        return data
    }
    ///发送数据包给设备
    func sendPacketWithPieces(data:Data, peripheral:CBPeripheral, characteristic:CBCharacteristic, type: CBCharacteristicWriteType = CBCharacteristicWriteType.withResponse) {
        
        let step = 20
        for index in stride(from: 0, to: data.count, by: step) {
            var len = data.count - index
            if len > step {
                len = step
            }
            let pData: Data = (data as NSData).subdata(with: NSRange(location: index, length: len))
            peripheral.writeValue(pData, for: characteristic, type: type)
        }
    }
    
    ///传出蓝牙传输数据
    func setDataBlock(block:@escaping BleDataBlock) {
        backDataBlock = block
    }
    
    ///传出当前扫描出来的设备信息
    func setPeripheralsBlock(block:@escaping BlePeripheralsBlock) {
        backPeripheralsBlock = block
    }
    
    ///传出已连接的设备的信息，该参数当前用于获取设备版本号
    func setConnectedBlock(block:@escaping BleConnectedBlock) {
        backConnectedBlock = block
    }
    
    func createFrame(data: Data) -> Data {
        let startByte: UInt8 = 0x01
        let endByte: UInt8 = 0x04
        let dataLength = UInt8(data.count)
        var checksum: UInt8 = 0

        for byte in data {
            checksum ^= byte
        }

        var frame = Data([startByte, dataLength])
        frame.append(data)
        frame.append(checksum)
        frame.append(endByte)

        return frame
    }
    
}

//MARK: - Ble Delegate  蓝牙中心的代理方法

extension BlueToothHelper:CBCentralManagerDelegate {
    // MARK: 检查运行这个App的设备是不是支持BLE。
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if #available(iOS 10.0, *) {
            if central.state == CBManagerState.poweredOn {
                print("powered on")
                // 蓝牙已启用，开始扫描设备
                startScan()
            } else {
                if central.state == CBManagerState.poweredOff {
                    print("BLE powered off")
                } else if central.state == CBManagerState.unauthorized {
                    print("BLE unauthorized")
                } else if central.state == CBManagerState.unknown {
                    print("BLE unknown")
                } else if central.state == CBManagerState.resetting {
                    print("BLE ressetting")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    /**
     didDiscoverPeripheral:
     peripheral: 扫描到的外设
     advertisementData: 外设的广告介绍信息
     RSSI: 外设信号强度  int类型
     */
    
    // 开始扫描之后会扫描到蓝牙设备，扫描到之后走到这个代理方法
    // MARK: 中心管理器扫描到了设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard !aPeArray.contains(peripheral), let deviceName = peripheral.name, deviceName.count > 0 else {
            return
        }
        
        if(!aPeArray.contains(peripheral)){
            aPeArray.append(peripheral)
        }
        
        //传出去实时刷新
        if let backPeripheralsBlock = backPeripheralsBlock {
            backPeripheralsBlock(aPeArray)
        }
        
        // 找到目标设备后停止扫描并保存设备
//        if peripheral.name == "Your Bluetooth Key Device Name" {
//            centralManager?.stopScan()
//            targetPeripheral = peripheral
//            
//            // 连接设备
//            centralManager?.connect(targetPeripheral!, options: nil)
//        }
    }
    //与一个外设成功的建立了连接时调用
    // MARK: 连接外设成功，开始发现服务
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("\(#function)连接外设成功。\ncentral:\(central),peripheral:\(peripheral)\n")
        // 设置代理
        self.peripheral = peripheral;
        self.peripheral?.delegate = self
        // 开始发现服务
        self.peripheral?.discoverServices(nil)
    }
    //与一个外设建立连接失败时调用
    // MARK: 连接外设失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("\(#function)连接外设失败\n\(String(describing: peripheral.name))连接失败：\(String(describing: error))\n")
        // 这里可以发通知出去告诉设备连接界面连接失败
        
        
    }
    ////在与外设的现有连接断开时调用
    // MARK: 连接丢失
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("\(#function)连接丢失\n外设断开：\(String(describing: peripheral.name))\n错误：\(String(describing: error))\n")
        // 这里可以发通知出去告诉设备连接界面连接丢失//在这里可以重连
        
    }
}

extension BlueToothHelper: CBPeripheralDelegate {
    
    ////当你发现外设的可用服务时调用
    //MARK: 匹配对应服务UUID
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error  {
            print("\(#function)搜索到服务-出错\n设备(peripheral)：\(String(describing: peripheral.name)) 搜索服务(Services)失败：\(error)\n")
            return
        } else {
            print("\(#function)搜索到服务\n设备(peripheral)：\(String(describing: peripheral.name))\n")
        }
        for service in peripheral.services ?? [] {
            //第一个参数 寻找指定的特征 为nil表示寻找所有特征
            //第二个参数: 寻找哪个服务的特征
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    //MARK: 发现服务的特征会调用的方法
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let _ = error {
            print("\(#function)发现特征\n设备(peripheral)：\(String(describing: peripheral.name))\n服务(service)：\(String(describing: service))\n扫描特征(Characteristics)失败：\(String(describing: error))\n")
            return
        } else {
            print("\(#function)发现特征\n设备(peripheral)：\(String(describing: peripheral.name))\n服务(service)：\(String(describing: service))\n服务下的特征：\(service.characteristics ?? [])\n")
        }
        
        for characteristic in service.characteristics ?? [] {
            if characteristic.uuid.uuidString.lowercased().isEqual(BLE_WRITE_UUID) {
                self.peripheral = peripheral
                writeCh = characteristic
                
                if let block = backConnectedBlock {
                    block(peripheral,characteristic)
                }
            } else if characteristic.uuid.uuidString.lowercased().isEqual(BLE_NOTIFY_UUID) {
                //该组参数无用
                notifyCh = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
                
                self.stopScan()
            }
            //此处代表连接成功
        }
    }
    
    // MARK: 获取外设发来的数据
    // 注意，所有的，不管是 read , notify 的特征的值都是在这里读取
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let _ = error {
            return
        }
        //拿到设备发送过来的值,传出去并进行处理
        if let dataBlock = backDataBlock, let data = characteristic.value {
            dataBlock(data)
        }
    }
    
    //MARK: 检测中心向外设写数据是否成功
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("\(#function)\n发送数据失败！错误信息：\(error)")
        }
    }
}
