//
//  addTableViewController.swift
//  tableView_sample
//
//  Created by Kiyoshi Ohashi on 2022/11/13.
//

import UIKit

class addTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTableView: UITableView!
    
    var memoTitleArray: [String] = []
    var appendTitle : String = ""
    
    let saveData = UserDefaults.standard
    
    @IBAction func toAddView() {
        self.performSegue(withIdentifier: "toAddView", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      loadMemo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let uuidArray = saveData.object(forKey: "uuidArray") as? [String] else {
            return print("Error!")
        }
        print(uuidArray)
        for i in uuidArray {
            appendTitle = (saveData.object(forKey: i) as! [String : String])["title"]!
            memoTitleArray.append(appendTitle)
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoTitleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel?.text = memoTitleArray[indexPath.row]
        return cell
    }
    
    func loadMemo(){
        if saveData.array(forKey: "uuidArray") != nil {
            let uuidArray = saveData.array(forKey: "uuidArray") as! [String]
            memoTitleArray = []
            for i in uuidArray {
                appendTitle = (saveData.object(forKey: i) as! [String : String])["title"]!
                memoTitleArray.append(appendTitle)
            }
            titleTableView.reloadData()
        }
    }


}
