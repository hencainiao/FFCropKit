//
//  ViewController.swift
//  example
//
//  Created by zlp003 on 2017/11/13.
//  Copyright © 2017年 张飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let img = UIImage.init(named: "img.jpg")
        let controller = PhotoImageViewControlelr.init()
        controller.data = UIImageJPEGRepresentation(img!, 1)
        self.present(controller, animated: true, completion: nil)
    }

}

