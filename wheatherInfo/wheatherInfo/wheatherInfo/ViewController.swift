//
//  ViewController.swift
//  wheatherInfo
//
//  Created by yuki_todate on 2017/08/12.
//  Copyright © 2017年 yuki_todate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var info: String?
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.infoLabel?.text = self.info
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

