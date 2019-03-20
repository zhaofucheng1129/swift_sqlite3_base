//
//  ViewController.swift
//  hangge_645
//
//  Created by hangge on 2017/4/25.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //获取数据库实例
        db = SQLiteDB.shared
        //打开数据库
        _ = db.openDB()
        //如果表还不存在则创建表（其中uid为自增主键）
        let result = db.execute(sql: "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        print(result)
        //如果有数据则加载
        initUser()
    }
    
    //点击保存
    @IBAction func saveClicked(_ sender: AnyObject) {
        saveUser()
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query(sql: "select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
    }
    
    //保存数据到SQLite
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
