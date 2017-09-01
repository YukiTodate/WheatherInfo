//
//  TableViewController.swift
//  wheatherInfo
//
//  Created by yuki_todate on 2017/08/12.
//  Copyright © 2017年 yuki_todate. All rights reserved.
//

    
import UIKit


class TableViewController: UITableViewController {

    
    // APIのURLを定義
    // APPID=XXXは先程取得したAPI KEYを各自設定してください
    var urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=Tokyo&APPID=04118274967875bb0174fc7803700fe2"
    var cellItems = NSMutableArray()
    let cellNum = 10
    var selectedInfo : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTableData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // セクション数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 1セクションあたりの行数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellNum
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        if self.cellItems.count > 0 {
            cell.textLabel?.text = self.cellItems[indexPath.row] as? String
        }
        return cell
    }
    
    // 継承時は書かれていない。メソッドを追加。
    // テーブルのcellを選択した時に呼ばれる関数。
    // その中で先ほど作成したsegueを呼び出して画面遷移させる
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //_ = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        self.selectedInfo = self.cellItems[indexPath.row] as! String
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    // segueで遷移するときに、行われる前処理
    // 今選択されたcellの情報を遷移先の画面に渡す
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let viewController : ViewController = segue.destination as! ViewController
            viewController.info = self.selectedInfo
        }
    }
    
    
    // APIをたたいて、配列に保存する
    // 非同期でAPIを叩いている
    func makeTableData() {
        let url = NSURL(string: self.urlString)!
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error in
            // リソースの取得が終わると、ここに書いた処理が実行される
            let json = try!JSON(data: data!)
            // 各セルに情報を突っ込む
            for i in 0 ..< self.cellNum {
                let dt_txt = json["list"][i]["dt_txt"]
                let weatherMain = json["list"][i]["weather"][0]["main"]
                let weatherDescription = json["list"][i]["weather"][0]["description"]
                let info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
                print(info)
                self.cellItems[i] = info
            }
            //self.tableView.reloadData()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()//データをもらってすぐに実行したい処理をかく
            }

        })
        
                task.resume()// この下には何も書かない
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
