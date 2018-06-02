//
//  OtherViewController2.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 天然 on 2018/5/18.
//  Copyright © 2018年 FireHsia. All rights reserved.
// Additions made by Turn The Page

import UIKit

class OtherViewController2: UIViewController {
    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let pdftitle="jinglebells"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let uimageview = UIImageView(frame: CGRect(x:35, y:100, width:300, height:300))
        let image = UIImage(named:"twinkle.jpg")
        uimageview.image = image
        self.view.addSubview(uimageview)
        let label = UILabel(frame:CGRect(x:35, y:420, width:300, height:100))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = "Test"
        self.view.addSubview(label)
        let button:UIButton=UIButton(type:.custom)
        button.frame=CGRect(x:170,y:550,width:80,height:25)
        button.backgroundColor = UIColor.brown
        button.setTitle("OPEN", for:.normal)
        button.setTitle("LOADING", for:.highlighted)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.view.addSubview(button)
        button.addTarget(self, action:#selector(openPDFAction(_:)), for:.touchUpInside)
        
    }
    
    
    
    @objc func openPDFAction(_ sender : Any){
        if let url=Bundle.main.url(forResource:pdftitle,withExtension:"pdf"){
            let webView=UIWebView(frame:self.view.frame)
            let urlRequest=URLRequest(url:url)
            webView.loadRequest(urlRequest as URLRequest)
            self.view.addSubview(webView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

