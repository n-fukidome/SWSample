//
//  ViewController.swift
//  StopWatchSample
//
//  Created by n-fukidome on 2014/08/28.
//  Copyright (c) 2014年 Nekojarashi. Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var displayTimeLabel: UILabel!
    
    //NSTimeInterva as Double
    var startTime = NSTimeInterval()
    var finTime = NSTimeInterval()
    var strMinutes = "00"
    var strSeconds = "00"
    var strFraction = "00"
    
    var timer = NSTimer()
    
    var counts = 0
    var record = "00:00:00"
    //var record: [String:String] = ["Minutes":"", "Seconds":"", "Fractions":""]
    var records = [String]()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func start(sender: AnyObject) {
        var tappedButton:UIButton = sender as UIButton
        
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            //enable to use "Stop"
            
            tappedButton.setTitle("counting", forState:UIControlState.Normal)
        } else if (counts > 0) {
            /*
            record = [
                "Minutes":strMinutes,
                "Seconds":strSeconds,
                "Fraction":strFraction
            ]
            */
            record = "\(strMinutes) : \(strSeconds) : \(strSeconds)"
            records.append(record)
            
        }
        counts++
        println(record)
        
    }

    @IBAction func stop(sender: AnyObject) {
        if timer.valid {
        
          finTime = NSDate.timeIntervalSinceReferenceDate()
        
          var elapsedTime: NSTimeInterval = finTime - startTime
          
          let minutes = UInt16(elapsedTime / 60.0)
          elapsedTime -= (NSTimeInterval(minutes) * 60)
        
          let seconds = UInt8(elapsedTime)
          elapsedTime -= NSTimeInterval(seconds)
        
          let fraction = UInt8(elapsedTime * 100)
        
          strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
          strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
          strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
          displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)  Count:\(counts)"
         
          timer.invalidate()
          //self.timer = nil
          startTime = 0.0
          counts = 0
        } else {
            displayTimeLabel.text = "00:00:00  Count:\(counts)"
        }
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if(segue.identifier == "TableViewController"){
            
            var controller = segue.destinationViewController as TableViewController
            controller.records = records
        }
    }
    
    
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        /*
        var strFraction : String
        if(fraction > 99){
            strFraction = String(fraction)
        }
        else if(fraction > 9){
            strFraction = "0" + String(fraction)
        }
        else {
            strFraction = "00" + String(fraction)
        }
        */
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)  Count:\(counts - 1)"
        }


}

