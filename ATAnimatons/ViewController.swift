//
//  ViewController.swift
//  ATAnimatons
//
//  Created by macpro on 2017/9/7.
//  Copyright © 2017年 macpro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let gySlider = GYSlider(frame: CGRect(x: 20, y: 20, width: 200, height: 80))
//
//        view.addSubview(gySlider)
        self.view.backgroundColor = UIColor.brown
        let view1 = InstrumentView(frame: CGRect(x: 50, y: 50, width: 280, height: 280))
        
        view.addSubview(view1)
        
//        let gyView = GYWaveView(frame: self.view.frame)
//        gyView.waveColors = [UIColor.red,UIColor.blue,UIColor.brown]
        
//        view.addSubview(gyView)
//         let filePath = Bundle.main.path(forResource: "ble", ofType: "bin")
//        GYTools.loadFileWithpath(filePath!)
        
        /*
        ROCommolOTA()
        let filePath = Bundle.main.path(forResource: "TwoCup", ofType: "bin")
        
        GYTools.loadFileWithpath(filePath!)
        
        
//        let data = NSData(contentsOfFile: filePath!)
//
//        var size = (data?.length)!
//
//        if size > 127 * 1024 {
//            print("文件过大")
//            return
//        }
//
//        if (size % 256) != 0 {
//            size = (size/256) * 256 + 256
//        }
        
//        let inputStream = InputStream(fileAtPath: filePath!)
//        
//        //        let readBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
//        
//        var readBuffer:[UInt8] = [UInt8].init(repeating: 0xff, count: size)
//        
//        memset(&readBuffer, 0xff, size)
//        memcpy(&readBuffer, data?.bytes, (data?.length)!)
//        //        inputStream?.read(&readBuffer, maxLength: (data?.length)!)
//        let allData = NSData.init(bytes: readBuffer, length: readBuffer.count)
//        //        Data.init(repeating: <#T##UInt8#>, count: <#T##Int#>)
//        
//        var temp:Int = 0
//        var Checksum = 0
//        let len = size/4 - 1
                
//        for i in 0...len {
//            
//            var value:UInt16 = 0
//            //
//            //            allData.getBytes(&value, range: NSRange.init(location: i * 4, length: 4))
//            //            temp += Int.init(UInt32(bigEndian: value))
//            //            temp += Int( CFSwapInt16BigToHost(value))
//            //            getUint(readBuffer, index: i)
//            
//            //           temp +=  getUint(allData, index: i * 4)
//            //            temp += Int(GYTools.big(toHostdata: allData as Data!, index: Int32(i * 4)))
//            temp += Int(GYTools.getBigHost(&readBuffer, index: Int32(i * 4)))
//            print(GYTools.getBigHost(&readBuffer, index: Int32(i * 4)))
//        }
//        print(temp)
//        var tempMask = CLongLong(0x1FFFFFFFF);
//        tempMask -= CLongLong(0x100000000)
//        print(tempMask)
//        
//        Checksum = Int(CLongLong(temp) & tempMask)
//        print(Checksum)
//        inputStream?.close()// 1464111506 TwoCup//2146531471
//        print(OznerTools.dataFromInt(number: CLongLong(Checksum), length: 4))
        

        
        //水杯 已OK
//        let filePath = Bundle.main.path(forResource: "TwoCup", ofType: "bin")
        
        let data = NSData(contentsOfFile: filePath!)! as Data
        print(Int((data.count)/16))
        
        var sum = Int((data.count)/16)
        
        if Int((data.count)%16) != 0 {
            sum += 1
        }
        print(UInt8(16))
        print(UInt16(16))
        for i in 0...sum {
            
            var sendData = Data.init(bytes: [0xC1])
            
            //固件包位置
            sendData.append(OznerTools.dataFromInt(number: CLongLong(i), length: 2))
            
            if i != sum {
                //固件包大小
                sendData.append(Data.init(bytes: [0x10]))
                sendData.append(data.subData(starIndex: i * 16, count: 16))

            } else {
                sendData.append(Data.init(bytes: [UInt8(data.count%16 == 0 ? 16 : data.count%16)]))
                sendData.append(data.subData(starIndex: i * 16, count: (data.count%16 == 0 ? 16 : data.count%16)))

            }

        }
        
        CheckSum(filePath!)
 */
        
    }
    

    func CheckSum(_ path:String) {
        
        
        let data = NSData(contentsOfFile: path)
        
        var size = (data?.length)!
        
        if size > 127 * 1024 {
            print("文件过大")
            return
        }
        
        if (size % 256) != 0 {
            size = (size/256) * 256 + 256
        }
    
        let inputStream = InputStream(fileAtPath: path)
        
//        let readBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        
        var readBuffer:[UInt8] = [UInt8].init(repeating: 0xff, count: size)
        
        memset(&readBuffer, 0xff, size)
        memcpy(&readBuffer, data?.bytes, (data?.length)!)
//        inputStream?.read(&readBuffer, maxLength: (data?.length)!)
        let allData = NSData.init(bytes: readBuffer, length: readBuffer.count)
//        Data.init(repeating: <#T##UInt8#>, count: <#T##Int#>)
        
        var temp:Int = 0
        var Checksum = 0
        let len = size/4 - 1
        
        
        
        for i in 0...len {
                        
//            var value:UInt16 = 0
//
//            allData.getBytes(&value, range: NSRange.init(location: i * 4, length: 4))
//            temp += Int.init(UInt32(bigEndian: value))
//            temp += Int( CFSwapInt16BigToHost(value))
//            getUint(readBuffer, index: i)
            
//           temp +=  getUint(allData, index: i * 4)
//            temp += Int(GYTools.big(toHostdata: allData as Data!, index: Int32(i * 4)))
           temp += Int(GYTools.getBigHost(&readBuffer, index: Int32(i * 4)))
            print(GYTools.getBigHost(&readBuffer, index: Int32(i * 4)))
        }
        print(temp)
        var tempMask = CLongLong(0x1FFFFFFFF);
        tempMask -= CLongLong(0x100000000)
        print(tempMask)
        
        Checksum = Int(CLongLong(temp) & tempMask)
        print(Checksum & 0x7fffffff)
        inputStream?.close()// 1464111506 TwoCup//2146531471
        print(OznerTools.dataFromInt(number: CLongLong(Checksum), length: 4))
 
        
    }
    
    fileprivate func ROCommolOTA() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func getint(_ byte:[UInt8] ,index:Int) -> Int {
//
//    }
    
    func getUint(_ byte:NSData ,index:Int) -> Int {
        

        let intData = byte.subdata(with: NSRange.init(location: index, length: 4)) as NSData
        
        var value:UInt32 = 0
        intData.getBytes(&value, length: 4)
        
        let value21 = CFSwapInt32(value)
        
        
//        NSData *intData = [data subdataWithRange:NSMakeRange(2, 4)];
//        int value = CFSwapInt32BigToHost(*(int*)([intData bytes]));
        
//        let value = CFSwapInt32BigToHost(index)
        
        
        return Int(value21)
        
    
//        let cureent = readBuffer[index]
//        readBuffer[index] = readBuffer[index + 3]
//        readBuffer[index + 1] = readBuffer[index + 2]
//        readBuffer[index + 2] = readBuffer[index + 1]
//        readBuffer[index + 3] = cureent
//        
//        
//        print(readBuffer)
//        print(((byte[index + 3] << 3) | ((byte[index + 2] ) << 2) | ((byte[index + 1] ) << 1) | ((byte[index]))))
//         return Int(UInt8((byte[index + 3] << 3) | ((byte[index + 2] ) << 2) | ((byte[index + 1] ) << 1) | ((byte[index]))))
        
        
//        print(( | ((byte[index + 2] & 0xff) << 16) | ((byte[index + 1] & 0xff) << 8) | ((byte[index] & 0xff))))
//        return Int.init((byte[index + 3] & 0xff << 4) | ((byte[index + 2] & 0xff) << 3) | ((byte[index + 1] & 0xff) << 2) | ((byte[index] & 0xff) << 1))
    
    }
}

