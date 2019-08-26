//
//  ListViewController.swift
//  TableViewController
//
//  Created by Berk Batuhan ŞAKAR on 24.08.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import Alamofire

struct CellData {
    let image : UIImage?
    let message : String?
}

class ListViewController: UITableViewController {
    
    
    
    var data = [CellData]()
    var sehirler = [CitiesModel]() //["İstanbul","Ankara","Adana"]
    @IBAction func insertCity(_ sender: UIBarButtonItem) {
        print("Ekleme Butonuna basıldı")
        
        
        
        
        let controller = UIAlertController(title: "Şehir Ekle", message: nil, preferredStyle: .alert)
        
        
        controller.addTextField { (textField) in
            textField.placeholder = "Şehir adı giriniz"
        }
        
        
        
        let addAction = UIAlertAction(title: "Ekle", style: .default) { (action) in
            let textField = controller.textFields!.first
            
            self.sehirler.insert(CitiesModel.init(name: textField!.text!, plaka: 60), at: 0)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "İptal Et", style: .default) { (action) in
            
        }
        
        controller.addAction(addAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        AF.request("https://gist.githubusercontent.com/serong/9b25594a7b9d85d3c7f7/raw/9904724fdf669ad68c07ab79af84d3a881ff8859/iller.json",method: .get).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            
//            switch response.result {
//            case .success(let value):
//                if let json = value as? [String: Any] {
//                    print(json)
//                }
//            case .failure(let error):
//                print(error)
//            }
//            if let json = response.dat {
//                print("JSON: \(json)") // serialized json response
//            }
            
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    //print("Data: \(utf8Text)") // original server data as UTF8 string
                    //let json = try! JSONDecoder().decode([Cities].self, from: response.data!)
                    
                    let cities = try? JSONDecoder().decode(Cities.self, from: response.data!)
                    print(cities ?? "")
                cities?.forEach({ (sehir) in
                        
                        let (key, value) = sehir
                        self.sehirler.append(CitiesModel.init(name: value, plaka: Int(key)!))
                        self.sehirler.sort(by: { $0.plaka < $1.plaka })
                        self.tableView.reloadData()
                    })
                    
                    

                }
        }
        //self.tableView.allowsSelection = false
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showdetail", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return sehirler.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sehirler.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = "Çalışcakmı"
        // Yukarıda return değerlerini önce 1 arttır.
        cell.textLabel?.text =  self.sehirler[indexPath.row].name?.capitalizingFirstLetter()
        cell.detailTextLabel?.text = String(self.sehirler[indexPath.row].plaka)
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sehirler.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */


    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVC {
            
            destination.cities = sehirler[(tableView.indexPathForSelectedRow?.row)!]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
 

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
