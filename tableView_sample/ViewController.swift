//
//  ViewController.swift
//  tableView_sample
//
//  Created by Kiyoshi Ohashi on 2022/11/13.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var textField: UITextField!
    
    var saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.text = ""
        textField.text = ""
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMemo() {
        
        let title = textField.text
        let context = textView.text
        if saveData.array(forKey: "uuidArray") != nil {
            
            let uuidArray = saveData.array(forKey: "uuidArray") as! [String]
            
            if title != "" && context != "" {
                let memo = Memo(title: title!, context: context!)
                addMemoData(memo: memo, uuidArray: uuidArray)
                addAlert(title: "メッセージ", message: "登録しました")
            } else {
                addAlert(title: "警告", message: "入力されていない項目があります")
            }
        } else {
            let newUUIDArray: [String] = []
            if title != "" && context != "" {
                let memo = Memo(title: title!, context: context!)
                addMemoData(memo: memo, uuidArray: newUUIDArray)
                addAlert(title: "メッセージ", message: "登録しました")
            } else {
                addAlert(title: "警告", message: "入力されていない項目があります")
            }
        }
        saveData.synchronize()
    }
    
    func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMemoData(memo: Memo, uuidArray: [String]) {
        let uuid = UUID().uuidString
        var memoDictionary = [String : String]()
        
        memoDictionary.updateValue(memo.title, forKey: "title")
        memoDictionary.updateValue(memo.context, forKey: "context")
        memoDictionary.updateValue(uuid, forKey: "uuid")
        
        saveData.set(memoDictionary, forKey: uuid)
        addingToUUIDArray(uuid: uuid, uuidArray: uuidArray)
        
    }
    
    func addingToUUIDArray(uuid: String, uuidArray: [String]) {
        var uuidArray = uuidArray
        uuidArray.append(uuid)
        saveData.set(uuidArray, forKey: "uuidArray")
    }
    
}


