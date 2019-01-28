//
//  Measure1.swift
//  Befit
//
//  Created by 이충신 on 21/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
// 기본 Measure 타입

import Foundation
import ObjectMapper

struct Measure1 : Mappable {
    

    var XL: Measure2?
    var L: Measure2?
    var M: Measure2?
    var S: Measure2?
    var XS: Measure2?
    
    var L2 : Measure2?
    var M2: Measure2?
    var S2: Measure2?
    
    var lsize: Measure2?
    var msize: Measure2?
    var ssize: Measure2?
    
    var nM: Measure2?
    var nL: Measure2?
    var nXL: Measure2?
    var nXXL: Measure2?
    
    var Ln: Measure2?
    var XLn: Measure2?
    var XXLn: Measure2?
    
    var one0: Measure2?
    var one1: Measure2?
    var two: Measure2?
    var Free: Measure2?
    var FREE: Measure2?
    var noOption: Measure2?

    var number1: Measure2?
    var number2: Measure2?
    var number3: Measure2?
    var number4: Measure2?
    
    var top1: Measure2?
    var top2: Measure2?
    var top3: Measure2?
    var top4: Measure2?
    var top5: Measure2?
    var top6: Measure2?
    var top7: Measure2?
    var top8: Measure2?
    
    var navy1: Measure2?
    var navy2: Measure2?
    var navy3: Measure2?
    var black: Measure2?
    var topL: Measure2?
    var topM: Measure2?
    
    var bottom1: Measure2?
    var bottom2: Measure2?
    var bottom3: Measure2?
    var bottom4: Measure2?
    var bottom5: Measure2?
    var bottom6: Measure2?
    
    var bottom01: Measure2?
    var bottom02: Measure2?
    var bottom03: Measure2?
    var bottom04: Measure2?
    var bottom05: Measure2?
    var bottom06: Measure2?
    var bottom07: Measure2?
    var bottom08: Measure2?
    var bottom09: Measure2?
    var bottom10: Measure2?
    var bottom11: Measure2?
    var bottom12: Measure2?
    var bottom13: Measure2?
    var bottom14: Measure2?
    var bottom15: Measure2?
    var bottom16: Measure2?
    var bottom17: Measure2?
    var bottom18: Measure2?
    var bottom19: Measure2?
    var bottom20: Measure2?
    var bottom21: Measure2?
    
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        XL <- map["XL"]
        L <- map["L"]
        M <- map["M"]
        S <- map["S"]
        XS <- map["XS"]
        
        L2 <- map["L(32~34)"]
        M2 <- map["M(30~32)"]
        S2 <- map["S(28~30)"]
       
        lsize <- map["L SIZE"]
        msize <- map["M SIZE"]
        ssize <- map["S SIZE"]
        
        nM <- map["1(M)"]
        nL <- map["2(L)"]
        nXL <- map["3(XL)"]
        nXXL <- map["4(XXL)"]
        
        Ln <- map["L(02)"]
        XLn <- map["XL(03)"]
        XXLn <- map["XXL(04)"]
        
        one0 <- map["1(ONE SIZE)"]
        one1 <- map["1(SIZE)"]
        two <- map["2(SIZE)"]
        Free <- map["Free"]
        FREE <- map["FREE"]
        noOption <- map["옵션없음"]
        
        number1 <- map["1"]
        number2 <- map["2"]
        number3 <- map["3"]
        number4 <- map["4"]
        
        top1 <- map["85"]
        top2 <- map["90"]
        top3 <- map["95"]
        top4 <- map["100"]
        top5 <- map["105"]
        top6 <- map["110"]
        top7 <- map["115"]
        top8 <- map["120"]
        
        navy1 <- map["네이비L(중량UP)"]
        navy2 <- map["네이비M(중량UP)"]
        navy3 <- map["네이비XL(중량UP)"]
        black <- map["블랙M"]
        
        topM <- map["상의-M"]
        topL <- map["상의-L"]
        
        bottom1 <- map["28"]
        bottom2 <- map["29"]
        bottom3 <- map["30"]
        bottom4 <- map["31"]
        bottom5 <- map["32"]
        bottom6 <- map["33"]
        
        bottom01 <- map["28/28"]
        bottom02 <- map["28/30"]
        bottom03 <- map["28/32"]
        bottom04 <- map["29/28"]
        bottom05 <- map["29/30"]
        bottom06 <- map["29/32"]
        bottom07 <- map["30/28"]
        bottom08 <- map["30/30"]
        bottom09 <- map["30/32"]
        bottom10 <- map["31/28"]
        bottom11 <- map["31/30"]
        bottom12 <- map["31/32"]
        bottom13 <- map["32/28"]
        bottom14 <- map["32/30"]
        bottom15 <- map["32/32"]
        bottom16 <- map["33/28"]
        bottom17 <- map["33/30"]
        bottom18 <- map["33/32"]
        bottom19 <- map["34/28"]
        bottom20 <- map["34/30"]
        bottom21 <- map["34/32"]
        
       
        
        
    }
    
    
    
}

