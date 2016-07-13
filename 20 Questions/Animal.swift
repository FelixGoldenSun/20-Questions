//
//  Animal.swift
//  20 Questions
//
//  Created by WALLS BENAJMIN A on 1/20/16.
//  Copyright © 2016 WALLS BENAJMIN A. All rights reserved.
//

import Foundation

class Animal{
    var name: String = "";
    var color: String = "";
    var legs: Int = 4;
    
    init (aName:String, aColor:String, aLegs:Int){
        name = aName;
        color = aColor
        legs = aLegs
    }
    
    func getName()->String{
        return name
    }
    
    func getColor()->String{
        return color
    }
    
    func getLegs()->Int{
        return legs
    }
    
    func to_s()->String{
        return "This animal is a \(name), it is \(color), and it has \(legs) legs.)"
    }
}
