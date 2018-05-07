//
//  ViewController.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Params & References
    
    @IBOutlet weak var tableView: UITableView!
    var rutas = DataSource()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Rutas Escolares"
        Alamofire.request("https://api.myjson.com/bins/10yg1t").responseJSON { response in
            if let answer = response.result.value as? [String : Any] {
                self.rutas = DataSource(JSON: answer)!
                self.tableView.reloadData()
            } else {
                print("ERROR")
            }
        }
        self.tableView.tableFooterView = UIView()
    }
    // MARK: TableView Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rutas.schoolBuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutasCell", for: indexPath) as! RutasTableViewCell
        
        let ruta = self.rutas.schoolBuses[indexPath.row]
        let randomColor : UIColor = .random
        
        cell.backgroundColor = randomColor
        cell.dataView.backgroundColor = randomColor
        cell.titleRutas.text = ruta.name
        cell.descriptionRutas.text = ruta.description
        
        let url = URL(string: ruta.imgUrl)
        cell.iconRutas.kf.indicatorType = .activity
        cell.iconRutas.kf.setImage(with: url, options: [.transition(.fade(0.8))])
        cell.iconRutas.contentMode = UIViewContentMode.scaleAspectFill
        cell.iconRutas.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detalleRuta", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // MARK: - Segue
    
    /// Función encargada de preprara todos los parametros que se requieran en el proximo `ViewController`.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = (tableView.indexPathForSelectedRow?.row)!
        let ruta = self.rutas.schoolBuses[index]
        print(ruta.name)
        print(ruta.description)
        
        if(segue.identifier == "detalleRuta"){
            
            let nextViewController = segue.destination as! DetalleRutaViewController
            
            nextViewController.nameRuta = ruta.name
            nextViewController.descriptionRuta = ruta.description
            nextViewController.stopsUrl = ruta.stopsUrl
        }
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

