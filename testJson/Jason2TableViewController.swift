//
//  Jason2TableViewController.swift
//  testJson
//
//  Created by sky on 2016/8/6.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit
import SDWebImage

class Jason2TableViewController: UITableViewController {
    
    //@IBOutlet weak var imageView: UIImageView!
    var dataArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613")
        let urlRequest = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data:Data?, respones:URLResponse?, err:Error?) -> Void in
            guard err == nil else{
                
                return
            }
            //JSON資料處理
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject] else {
                return
            }
            
            //依據先前觀察的結構，取得result對應中的results所對應的陣列
            //let dataStr = String(data: data, encoding: String.Encoding.utf8)
            guard let dataArray = json["results"] as? [[String:AnyObject]] else{
                return
            }
            
            self.tableView.reloadData()
            
            for appDic in dataArray {
                print("trackName \(appDic["trackName"]!)")
                
            }
            
        }
        
        
        task.resume() //重啟下載的動作
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    //section裡的細部欄位

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }//storyboard的tableView裡的secion欄位數量

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]["A_Name_Ch"] as? String
        print("cell")
        
        /*let imageView = cell.contentView.viewWithTag(2) as! UIImageView
        let urlStr:String
        
        if indexPath.row % 2 == 0 {
            urlStr = "https://www.otaku-hk.com/pkmgo/pokedex/1"
        }
        else {
            
            urlStr = ""
        }
        //let url = URL(string: urlStr)
        //imageView.sd_setImage(with: url, placeholderImage: nil)*/
        
        
        
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
