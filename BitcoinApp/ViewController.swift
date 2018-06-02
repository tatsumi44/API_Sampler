//
//  ViewController.swift
//  BitcoinApp
//
//  Created by tatsumi kentaro on 2018/06/02.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var timer = Timer()
    var Lastprice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        fetchPrice()
        roop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func fetchPrice() {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        
        
        Alamofire.request("https://coincheck.com/api/ticker", method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            let json = JSON(response.result.value)
            print(json["bid"].int)
            self.priceLabel.text = String(json["bid"].int!)
            self.dateLabel.text = formatter.string(from: now)
            var price:Int = json["bid"].int!
            if price >= self.Lastprice{
                self.view.backgroundColor = UIColor.red
            }else if price == self.Lastprice{
                self.view.backgroundColor = UIColor.white
            }else{
                self.view.backgroundColor = UIColor.blue
            }
            self.Lastprice = json["bid"].int!
            
            
            
            print(response.result.value!)
        }
    }
    func roop() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.fetchPrice), userInfo: nil, repeats: true)
    }
    


}

