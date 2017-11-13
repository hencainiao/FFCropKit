//
//  PhotoImageContentView.swift
//  HeyZhimaProduct
//
//  Created by zlp003 on 2017/11/3.
//  Copyright © 2017年 zlp001. All rights reserved.
//

import UIKit
let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
enum TouchLocation {
    
    case north
    case south
    case west
    case east
    case center
    case west_north
    case west_south
    case east_north
    case east_south
}

/// 图片容器视图
class PhotoImageContentView: UIView {
    
    var imageView = UIImageView()
    var clipImageView = CropImageView.init(frame: CGRect.zero)
    var newImageView = UIImageView()
    var newClipImageView = UIImageView()
    var grayCoverView:UIView = UIView()
    
    var rotateBtn = UIButton()
    var saveBtn = UIButton()
    var hwRate:CGFloat = 1
    
    var angle = 0.0
    var orientation:UIImageOrientation = .up
    var scrollContentView = OriginalImageView()
    var editBackImage:((UIImage?)->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        imageView = UIImageView.init()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 加载图片，确定视图大小
    ///
    /// - Parameter data: 图片二进制数据
    func imageData(data:Data)  {
        let image = UIImage.init(data: data)
        
        imageView.center.x = self.center.x
        imageView.center.y = self.center.y - 50

        hwRate = (image?.size.height)!/(image?.size.width)!
        var w = kScreenW - 30
        var h =  (kScreenW - 30) * hwRate
        
        
        if h > kScreenH  - 100 - 20 {
            h = kScreenH  - 100 - 20
            w = h / hwRate
        }
        
        imageView.bounds.size = CGSize.init(width: w, height: h)
        imageView.image = image
        
        scrollContentView = OriginalImageView.init(frame: imageView.frame)
        self.addSubview(scrollContentView)
        scrollContentView.contentImg.image = image
        
        
        grayCoverView.frame = self.frame
        grayCoverView.isUserInteractionEnabled = false
        grayCoverView.backgroundColor = UIColor.black
        grayCoverView.alpha = 0.7
        grayCoverView.isHidden = true
        self.addSubview(grayCoverView)
        
        clipImageView.frame = imageView.frame
        clipImageView.isUserInteractionEnabled = true
        clipImageView.originalFrame = imageView.frame
        clipImageView.image = UIImage.init(named: "camer_aaperture")
        self.addSubview(clipImageView)
        
        clipImageView.closure = {[weak self] in
            if (self?.scrollContentView.contentScr.zoomScale)! > 1 {
                return false
            }
            return true
        }
        clipImageView.pinchClosure = {[weak self] (scale:CGFloat) in
            self?.scrollContentView.contentScr.zoomScale = scale
        }
        
        clipImageView.edageClosure = {[weak self] (edage:UIEdgeInsets) in
            self?.scrollContentView.edageScrollInset? = edage
        }
        clipImageView.cropClosure = {[weak self] in
            self?.cropImage()
        }
        clipImageView.removeImageClosure = {[weak self]in
            self?.removeCropImage()
        }
        scrollContentView.snapClosure = {[weak self] in
    
            self?.clipImageView.cropTimeFire()
        }
        
     
        self.rotateBtn.frame = CGRect.init(x: kScreenW/2 - 25, y: kScreenH-100, width: 50, height: 50)
        self.rotateBtn.setImage(UIImage.init(named: "-photo_btn_rotate"), for: UIControlState.normal)
        self.addSubview(rotateBtn)
        self.rotateBtn.addTarget(self, action: #selector(rotateImage), for: UIControlEvents.touchUpInside)
        
        self.saveBtn.frame = CGRect.init(x: 0, y: kScreenH-50, width: kScreenW, height: 50)
        self.saveBtn.setTitle("保存", for: UIControlState.normal)
        self.saveBtn.backgroundColor = UIColor.colorWithHexString("#479cf2")
        self.saveBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.addSubview(saveBtn)
        self.saveBtn.addTarget(self, action: #selector(saveImage), for: UIControlEvents.touchUpInside)
        
        
    }
   

    /// 旋转图片
    @objc func rotateImage()  {
        
        self.removeCropImage()
        var w = kScreenW - 30
        var h = (kScreenW - 30) * hwRate
        let imgMaxHeight = kScreenH  - 100 - 20
        
        angle = angle + Double.pi/2
        
        if angle == Double.pi/2 + 2*Double.pi {
            angle = Double.pi/2
        }
        
        switch angle {
        case Double.pi/2:
            orientation = .right
            imageView.center.x = self.center.x
            imageView.center.y = self.center.y - 50
            if h > w {
                h = w
                w = h / hwRate
            }else{
                w = kScreenH - 200
                h = w * hwRate
            }
        case Double.pi:
            orientation = .down
            if h > imgMaxHeight {
                h = imgMaxHeight
                w = h / hwRate
            }
        case 3*Double.pi/2:
            orientation = .left
            imageView.center.x = self.center.x
            imageView.center.y = self.center.y - 50
            if h > w {
                h = w
                w = h / hwRate
            }else{
                w = kScreenH - 200
                h = w * hwRate
            }
        case 2*Double.pi:
            orientation = .up
            if h > imgMaxHeight {
                h = imgMaxHeight
                w = h / hwRate
            }
        default:
            return
        }
        imageView.bounds.size = CGSize.init(width: w, height: h)
        imageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(angle))
        clipImageView.transform =  imageView.transform
        clipImageView.orientation = orientation
        
        scrollContentView.transform = imageView.transform
        scrollContentView.frame = imageView.frame
        scrollContentView.contentScr.frame = imageView.bounds
        scrollContentView.contentScr.zoomScale = 1.0
        scrollContentView.contentImg.frame = imageView.bounds
        scrollContentView.edageScrollInset = UIEdgeInsets.zero
        scrollContentView.contentScr.contentInset = UIEdgeInsets.zero
        scrollContentView.contentScr.contentSize = imageView.bounds.size
        clipImageView.frame =  CGRect.init(x: imageView.x + 2, y: imageView.y + 2, width: imageView.width - 4, height: imageView.height - 4)
        clipImageView.originalFrame = imageView.frame
       
    }
    
    /// 保存裁剪图片
    @objc func saveImage()  {
        
        if let image = self.cropImageFromImageView() {
            UIImageWriteToSavedPhotosAlbum(image, self,#selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    /// 保存成功回调
    ///
    /// - Parameters:
    ///   - image: 保存的图片
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {

        if error != nil {
            
        } else {
            editBackImage?(image)
        }
    }
    
    /// 移除点缀视图
    func removeCropImage()  {
        newImageView.removeFromSuperview()
        newClipImageView.removeFromSuperview()
        grayCoverView.isHidden = true
    }
    
    
    /// 裁剪图片
    func cropImage() {
        
        if let image = self.cropImageFromImageView() {
            newImageView.frame = clipImageView.frame
            self.addSubview(newImageView)
            newImageView.image = image
            
            newClipImageView.frame = newImageView.frame
            self.addSubview(newClipImageView)
            newClipImageView.image = UIImage.init(named: "camer_aaperture")
            
            grayCoverView.isHidden = false
        }
        
    }

    /// 通过imageView获取裁剪视图
    ///
    /// - Returns: image
    func cropImageFromImageView() -> UIImage?  {
        
        var cropRatioX:CGFloat = 1
        var cropRatioY:CGFloat = 1
        let zoomScale = scrollContentView.contentScr.zoomScale
        let imgW = (self.imageView.image?.size.width)!
        let imgH = (self.imageView.image?.size.height)!
        let imageViewW = self.imageView.frame.size.width
        let imageViewH = self.imageView.frame.size.height
        
        switch orientation {
        case .right,.left:
            cropRatioX = imgH/(imageViewW * zoomScale)
            cropRatioY = imgW/(imageViewH * zoomScale)
        default:
            cropRatioX = imgW/(imageViewW * zoomScale)
            cropRatioY = imgH/(imageViewH * zoomScale)
        }
        let rect = self.clipImageView.convert(self.clipImageView.bounds, to: scrollContentView.contentScr)
        
        return  self.imageView.image?.cropToSquare(area: rect, ratioX: cropRatioX, ratioY: cropRatioY, orientation: orientation)
       
    }

  
}



