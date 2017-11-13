//
//  PhotoImageViewControlelr.swift
//  TestXcode9
//
//  Created by zlp003 on 2017/11/13.
//  Copyright © 2017年 zlp. All rights reserved.
//

import UIKit
class PhotoImageViewControlelr: UIViewController {
    
    var data:Data?
    
    var editBackImage:((UIImage?)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = PhotoImageContentView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH))
        imageView.imageData(data: data!)
        imageView.editBackImage = editBackImage
        self.navigationItem.title = "编辑照片"
        self.view.addSubview(imageView)
        
        let closeBtn = UIButton()
        closeBtn.frame = CGRect.init(x: 10, y: 10, width: 50, height: 50)
        closeBtn.setImage(UIImage.init(named: "nav_btn_close2"), for: UIControlState.normal)
        self.view.addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
    }
    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }
    
}
