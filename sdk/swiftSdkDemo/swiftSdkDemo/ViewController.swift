//
//  ViewController.swift
//  swiftSdkDemo
//
//  Created by 朱海铭 on 2018/4/18.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

import UIKit
import anXingBaoSDK


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        AXBSDK.init();
        AXBSDK.init().apiKey(key: "6649E047900DF81965E618E0E3C7F960", amapKey: "d4ff2d82de004b63113d669d7120dae0"); // 验证key
        self.title = "swift-demo";
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title:[String] = ["直接进入设备列表控制器", "进入自定义的控制器"];
        let subTitle:[String] = ["sdk自带的控制器", "可以控制设备列表view的frame"];
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell");
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        }
        cell?.textLabel?.text = title[indexPath.row];
        cell?.detailTextLabel?.text = subTitle[indexPath.row];
        cell?.imageView?.image = initImage(name: "AlertIcon")
        return cell!;
    }
    
    func initImage(name:String) -> UIImage? {
        if let image = UIImage.init(named: "anXingBao.bundle/" + name) {
            print("image not nil")
            return image;
        } else {
            print("image is nil \(name)")
            return nil;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if indexPath.row == 0 {
            presentSDKList();
        } else if indexPath.row == 1 {
            pushMyList();
        }
    }
    
    func presentSDKList() {
        let sdk = AXBSDK.init();
        sdk.tokenFaild = {
            // sdk token过期
            print("token faild")
        }
        sdk.login(username: "yukari", pass: "198611", controller: self, faild: { (msg, detail) in
            // 登录sdk失败
            print("msg == \(msg, detail)")
        }) {
            // 登录sdk成功
            print("success login")
        };
    }
    
    
    func pushMyList() {
        let sdk = AXBSDK.init();
        sdk.tokenFaild = {
            print("token faild")
        }
        let pro = MyViewController.init();
        weak var nacv = UINavigationController.init(rootViewController: pro);
        weak var weakPro = pro;
        weak var weakSelf = self;
        sdk.deviceListBlock = {(vc) in
            vc.view.tag = 100; // 设定view的tag 用于标识
            weakPro?.setChildVC(device: vc);
            weakSelf!.present(nacv!, animated: true, completion: nil);
        }
        sdk.login(username: "yukari", pass: "198611", controller: pro, faild: { (msg, detail) in
            print("msg == \(msg, detail)")
        }) {
            print("success login")
            
        };
    }

}

