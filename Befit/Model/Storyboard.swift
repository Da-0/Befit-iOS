//
//  Storyboard.swift
//  Befit
//
//  Created by 이충신 on 03/02/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class Storyboard {
    
    let main = UIStoryboard(name: "Main", bundle: nil)
    let login = UIStoryboard(name: "LogIn", bundle: nil)
    let search = UIStoryboard(name: "Search", bundle: nil)
    let rank = UIStoryboard(name: "Rank", bundle: nil)
    let like = UIStoryboard(name: "Like", bundle: nil)
    let myPage = UIStoryboard(name: "MyPage", bundle: nil)
    let brand = UIStoryboard(name: "Brand", bundle: nil)
    let product = UIStoryboard(name: "Product", bundle: nil)
    
    struct StaticInstance {
        static var instance: Storyboard?
    }
    
    class func shared() -> Storyboard {
        if StaticInstance.instance == nil {
            StaticInstance.instance = Storyboard()
        }
        return StaticInstance.instance!
    }
}
