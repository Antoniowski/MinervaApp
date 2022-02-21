//
//  PercentageFunctions.swift
//  Minerva
//
//  Created by Antonio Romano on 21/02/22.
//
import SwiftUI

class PercentageManager{
    @State var percentage: Float = 0
    private let lowWeight: Float = 0.75
    private let midWeight: Float = 1
    private let highWeight: Float = 1.25
    var relativeLow: Float = 0
    var relativeMid: Float = 0
    var relativeHigh: Float = 0
    
    func percentageCalc(lowQty: Float, midQty: Float, highQty: Float){
        relativeLow = lowWeight/(lowQty*lowWeight+midQty*midWeight+highQty*highWeight)
        relativeMid = midWeight/(lowQty*lowWeight+midQty*midWeight+highQty*highWeight)
        relativeHigh = highWeight/(lowQty*lowWeight+midQty*midWeight+highQty*highWeight)
    }
}
