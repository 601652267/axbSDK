//
//  MyViewController.swift
//  swiftSdkDemo
//
//  Created by 朱海铭 on 2018/4/18.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

import UIKit
import anXingBaoSDK

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar();
        
        // Do any additional setup after loading the view.
    }
    
    func barItem(title:String, sel:Selector?) -> UIBarButtonItem {
        return UIBarButtonItem.init(title: title, style: .plain, target: self, action: sel);
    }
    
    func setNavagationBar() {
        self.navigationItem.leftBarButtonItem = barItem(title: "返回", sel: #selector(leftAction));
        self.navigationItem.rightBarButtonItems = [barItem(title: "退出", sel: #selector(loginOut)), barItem(title: "绑定", sel: #selector(bindDevice))]
    }
    
    //MARK:-
    /* 嵌套controller */
    func setChildVC(device:UIViewController) {
        self.view.addSubview(device.view);
        self.view.backgroundColor = .white;
        self.addChildViewController(device);
    }
    
    /* 在自定义控制器里需要实现该方法 */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        for view in self.view.subviews {
            if view.tag == 100 /* 100是view的tag 用于标识 */ {
                view.frame = returnViewFrame();
            }
        }
    }
    
    // 设定view的frame
    func returnViewFrame() -> CGRect {
        let height:CGFloat = 300;
        let width = self.view.frame.size.width;
        let pointx:CGFloat = 30;
        let pointy:CGFloat = 100;
        return CGRect.init(x: pointx, y: pointy, width: (width - pointx * 2), height: height)
    }
    //MARK:-

    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc func loginOut() {
        let sdk = AXBSDK.init();
        sdk.loginOut();
    }
    
    @objc func bindDevice() {
        let sdk = AXBSDK.init();
        sdk.bindDevice(controller: self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
