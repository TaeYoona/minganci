//
//  ViewController.swift
//  WordFilterHelper
//
//  Created by zhangcong on 2017/10/13.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let str = WordFilterHelper.shareInstance.filter(str: "我爱胡锦涛")
        print(str)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

