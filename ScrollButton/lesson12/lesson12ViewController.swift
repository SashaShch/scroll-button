//
//  lesson12ViewController.swift
//  ScrollButton
//
//  Created by Рома on 16.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class lesson12ViewController: UIViewController {
    
    var catInfo = Cat(catInfo: [])
    let catCount = 10
    
    @IBOutlet weak var tableView: UITableView!
    
    let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://api.thecatapi.com/v1/breeds"
        
        if let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let response = try? self.decoder.decode([Item].self, from: data) {
                        DispatchQueue.main.async {
                            for i in 0...self.catCount {
                                if let item = response[i] as? Item {
                                    
                                    let cat = (item.name, item.temperament)
                                    self.catInfo.catInfo.append(cat)
                                    
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
}



extension lesson12ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catInfo.catInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellView
        cell = tableView.dequeueReusableCell(withIdentifier: "info cell", for: indexPath) as! CellView
        
        cell.breedLabel.text = catInfo.catInfo[indexPath.item].0
        cell.temperamentLabel.text = catInfo.catInfo[indexPath.item].1
        return cell
    }
}
extension lesson12ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
