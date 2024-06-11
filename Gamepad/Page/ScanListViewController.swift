//
//  ScanListViewController.swift
//  Gamepad
//
//  Created by chao on 2024/6/3.
//

import UIKit
import CoreBluetooth

class ScanListViewController: UIViewController {
    
    let cellID = "cellIdentifier"
    var bleHelper = BlueToothHelper.shared
    var pArray:[CBPeripheral] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .top
        setUI()
        setData()
        bleHelper.startScan()
    }

    func setUI() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        tableView.frame = CGRect(x: 0, y: 22, width: width, height: height - 22)
        view.addSubview(tableView)
    }
    
    func setData() {
        bleHelper.setPeripheralsBlock { (peArray) in
            self.pArray = peArray
            self.tableView.reloadData()
        }
        
        bleHelper.setConnectedBlock { (backPe, backCh) in
            print("设备已连接，peripheral:\(backPe)，characteristic:\(backCh)")
        }
        
        bleHelper.setDataBlock { (data) in
            print("ble data:\([UInt8](data))")
        }
    }
    
    //MARK: Lazy Load
    
    lazy var tableView: UITableView = {
        let tTableView = UITableView(frame: CGRect.zero)
        tTableView.delegate = self
        tTableView.dataSource = self
        tTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        return tTableView
    }()

}

extension ScanListViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let p = pArray[indexPath.row]
        cell.textLabel?.text = p.name  ?? ""
        cell.detailTextLabel?.text = p.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bleHelper.doConnect(peripheral: pArray[indexPath.row])
    }
}
