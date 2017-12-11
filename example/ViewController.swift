//
//  ViewController.swift
//  example
//
//  Created by zlp003 on 2017/11/13.
//  Copyright © 2017年 张飞. All rights reserved.
//

import UIKit

class NNumber:NSObject {
    var A:String?
    var B:String?
    var C:String?
    var D:String?
}

enum ENUmber {
    case A
    case B
    case C
    case D
    
    //    枚举中不允许使用存储属性
    var a: String {
        return ""
    }
    
    var array:Array<Any> {
        
        return []
    }
    
    var dic:Dictionary<AnyHashable, Any> {
        
        return [:]
    }
    
    
    
}

struct SNumber {
    //
    var a :String = ""
    
}

protocol ProtocolC {
    associatedtype T
    
    func getxx(item:T) -> T
}


protocol PA {
    func hhhh()
}
extension PA{
    func hhhh(){
        print("-----------")
    }
}
protocol PB:ProtocolC{
    func hhhh()
}

extension PB where Self:PB{
    func hhhh()  {
        print("+++++++++++")
    }
}
struct StructA:ProtocolC{
    typealias T = TestModel.Type
    func getxx(item:T) ->T {
        
        return item
    }
    
    var a = ""
    var b:Int?
    
}
protocol ProtocolA {
    func testP()
}

protocol ProtocolB {
    func testB()
}
@objcMembers class TestModel : NSObject,ProtocolA {
    
    var b:String = ""
    
    var a : String = ""
    override open func setValue(_ value: Any?, forUndefinedKey key: String){
        super.setValue(value, forUndefinedKey: key)
    }
    
    func testP() {
        print("------------------testP")
    }
    
}

class TestModel2: NSObject,ProtocolB {
    func testB() {
        print("--------------testB")
    }
}

@objcMembers class ViewController: UIViewController,PA {
    
    
    
    var a:TestModel?
    
    
    var str : String?
    var str1 : String?
    
    
    func getPropertyList(cls:Any) ->[String] {
        var attArray:[String] = []
        
        var proNum:UInt32 = 0
        
        let cls:AnyClass = cls as! AnyClass
        
        let properites = class_copyIvarList(cls, &proNum)
        
        for index in 0..<numericCast(proNum) {
            
            let prop:objc_property_t = properites![index]
            let attrName = String.init(cString: property_getAttributes(prop)!)
            print("p_attr：\(String.init(cString: property_getAttributes(prop)!))")
            attArray.append(attrName)
            
        }
        
        return attArray
        
    }
    
    func testsss(data:Any)  {
        let respondData : NSData = (data as! String).data(using: String.Encoding.utf8)! as NSData
        
        
        let respond:NSDictionary?  = try? JSONSerialization.jsonObject(with: respondData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        if respond?["action"] != nil{
            
            if (respond?["action"] as! String) == "ping"{
                //                self?.socketSendMessage(["action" : "pingBack" as AnyObject])
                return
            }
            
        }
        if respond?["content"] != nil {
            
            //            let message : [AnyHashable: Any]? = self?.decrypt(dataStr: (respond["content"] as? String)!) as? [AnyHashable: Any]
            
            //            self?.receiveMessageFromWebScoket(info: message)
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let img = UIImage.init(named: "img.jpg")
        let controller = PhotoImageViewControlelr.init()
        controller.data = UIImageJPEGRepresentation(img!, 1)
        self.present(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        
        
        
        ////        let dict1 = ["key":"value"]
        //        let dict1 = ["hhhhh"]
        //
        //        let rs = JSONSerialization.isValidJSONObject(dict1)
        //
        //        if rs == false{
        //            return
        //        }
        //
        //        let d = try? JSONSerialization.data(withJSONObject: dict1, options: JSONSerialization.WritingOptions.sortedKeys)
        //
        //        let string = String.init(data: d!, encoding: String.Encoding.utf8)
        //
        //        let xxx = "-----"
        //
        //        let data = xxx
        //
        //        let respondData :Data = (data as! String).data(using: String.Encoding.utf8)! as Data
        //
        //       let ooooo =  try? JSONSerialization.jsonObject(with: respondData, options: JSONSerialization.ReadingOptions.mutableContainers)
        //
        //        print(ooooo)
        //
        //        self.testsss(data: data)
        //        let respond : NSDictionary = try? JSONSerialization.jsonObject(with: respondData , options: JSONSerialization.ReadingOptions.mutableContainers)
        
        //        print(respond)
        
        //将user对象进行反射
        //        let hMirror = Mirror(reflecting: NNumber.self)
        //
        //        print("对象类型：\(hMirror.subjectType)")
        //        print("对象子元素个数：\(hMirror.children.count)")
        //
        //
        //
        //
        //        print(NNumber.self)
        //
        //        self.getPropertyList(cls: NNumber.self)
        //
        //
        //
        //        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //
        //        let Clazz:AnyClass? =  NSClassFromString(namespace + "." + "hfdsjk")
        //
        //        let Class = Clazz as? NSObject.Type
        //
        //
        //        let router = Class?.init()
        //
        //
        //
        //        let list:[Any] = [TestModel(),TestModel2()]
        //
        //         self.a = TestModel()
        //
        ////        self.a?.setValue("aa", forKeyPath: "a")
        //
        //         self.a?.setValue("aa", forKey: "a")
        //
        ////        print(self.a?.value(forKey: "a"))
        //
        //
        //        self.setValue(TestModel(), forKeyPath: "a")
        //
        //        let model = self.value(forKey: "a") as! TestModel
        //
        //        print(model)
        //
        //        for x in list {
        //            if let temp =  x as? ProtocolA {
        //                temp.testP()
        //            }
        //
        //            if let temp = x as? ProtocolB{
        //                temp.testB()
        //            }
        //        }
        //
        //
        //
        //
        //
        //
        //        var url = URL.init(string: "http://11/22#acc=111")
        //
        //        url = url?.appendingPathComponent("/hello")
        //
        //        print(url?.absoluteString)
        //
        //
        //        let dict:[AnyHashable:Any] = [1:"222"]
        //
        //        let res = dict as! [Int:String]
        //
        //        let a = dict[1] as? Int8
        //
        //        print(res)
        //
        //        let array = [1,2,3,4,5]
        //
        //        let array2 =  array.map { $0 + 1}
        //
        //       let array3 =  array.map { (item)->Int in
        //            return  item + 1
        //        }
        //
        //        let result =  array.reduce("") { (result, item) -> String in
        //            return result + String(item)
        //        }
        //        let result2 =  array.reduce("") {
        //             $0 + String($1)
        //        }
        //
        //       let array4 =  array.filter { (item) -> Bool in
        //            return item > 3
        //       }
        //        let array5 =  array.filter {$0 > 2}
        //        print("array4\(array4)")
        //        print("array5\(array5)")
        //        print(result)
        //        print(result2)
        //        print(array3)
        //        print(array2)
        //
        //
        //        let dic = ["key":"1","key2":"2","key3":"3"]
        //
        //        let dic2 =   dic.map { (key,value) -> String in
        //            return key
        //        }
        //        print("dic2\(dic2)")
        //        // Do any additional setup after loading the view, typically from a nib.
        //
        //        self.test()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

