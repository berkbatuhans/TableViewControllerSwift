//
//  DetailVC.swift
//  TableViewController
//
//  Created by Berk Batuhan ŞAKAR on 27.08.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    @IBOutlet weak var lblCities : UILabel!
    @IBOutlet weak var lblIlceler : UILabel!
    
    var cities: CitiesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCities.text = "\((cities?.name)!) - \((cities?.plaka)!)"
        self.navigationItem.title = cities?.name
        let url: String = "http://kocakrecep.com/api/v1/GetSehir?plakaid=" + String(cities!.plaka)
        print(url)
        AF.request(url, method: .post).responseJSON { response in
            
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                //let json = try! JSONDecoder().decode([Cities].self, from: response.data!)
                
                let cities = try? JSONDecoder().decode(Ilce.self, from: response.data!)
                print(cities ?? "")
                var metin = ""
                cities?.forEach({ (sehir) in
                    
                    print(sehir)
                    metin += sehir.ilceAdi
//                    self.sehirler.append(CitiesModel.init(plaka: sehir.plaka, name: sehir.name))
//                    self.sehirler.sort(by: { $0.plaka < $1.plaka })
//                    self.tableView.reloadData()
                })
                
                self.lblIlceler.text = metin
                
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
