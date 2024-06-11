//
//  GamePadState.swift
//  Gamepad
//
//  Created by chao on 2024/6/11.
//

import UIKit

class GamePadReport{
    
    
    var gamePadData:[Int8] = []
    
    func setValue(s : GamePadState) -> [Int8]{
        // 11 buttons: A, B, X, Y, L1, R1, L3, R3, Power, Back, Home (1 bit per button), 1 bit padding
                // 4 bits for D-pad rotation values 0-7 -> 0-315 (360 - 45)
                // 6x 8-bit values for LX/LY, RX/RY, L2/R2
        gamePadData[0] = 0;
        gamePadData[0] |= (Int8) (s.a ? 0x01 : 0);
        gamePadData[0] |= (Int8) (s.b ? 0x02 : 0);
        gamePadData[0] |= (Int8) (s.x ? 0x04 : 0);
        gamePadData[0] |= (Int8) (s.y ? 0x08 : 0);
        gamePadData[0] |= (Int8) (s.l1 ? 0x10 : 0);
        gamePadData[0] |= (Int8) (s.r1 ? 0x20 : 0);
        gamePadData[0] |= (Int8) (s.l3 ? 0x40 : 0);
        gamePadData[0] |= (Int8) (s.r3 ? 0x80 : 0);
        gamePadData[1] = 0;
        gamePadData[1] |= (Int8) (s.start ? 0x01 : 0);
        gamePadData[1] |= (Int8) (s.back ? 0x02 : 0);
        gamePadData[1] |= (Int8) (s.home ? 0x04 : 0);
        gamePadData[1] |= (Int8) (s.dPad << 4);
        gamePadData[2] = s.lx;
        gamePadData[3] = s.ly;
        gamePadData[4] = s.rx;
        gamePadData[5] = s.ry;
        gamePadData[6] = s.l2;
        gamePadData[7] = s.r2;
         return gamePadData;
    }
}


class GamePadState: NSObject {
    
    
    var a :Bool = false
    var b :Bool = false
    var x :Bool = false
    var y :Bool = false
    var l1 :Bool = false
    var r1 :Bool = false
    var l3 :Bool = false
    var r3 :Bool = false
    var start :Bool = false
    var back :Bool = false
    var home :Bool = false
    
    // 0=up, 2=right, 4=down, 6=left, 8=release
    var dPad:Int8 = 8
    // Sticks: Up=0, Down=255, Left=0, Right=255, Center=128
    var lx:Int8 = 0
    var ly:Int8 = 0
    var rx:Int8 = 0
    var ry:Int8 = 0
    
    // Triggers: Released=0, Pressed=255
    var l2:Int8 = 0
    var r2:Int8 = 0
    
}
