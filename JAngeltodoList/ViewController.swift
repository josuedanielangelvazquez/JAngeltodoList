//
//  ViewController.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 03/04/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var Datetodaylbl: UILabel!
    
    @IBOutlet weak var tareastableview: UITableView!
    
    var daynumber = ""
    var dataSource = ["Enero", "Febrero"]
    var tasks = [Tasck]()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
   
    var tareasvfiewmodel = TareasViewModel()
    
    @IBOutlet weak var CollectionDays: UICollectionView!
    var day = [days]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CollectionDays.delegate = self
        CollectionDays.dataSource = self
        view.addSubview(CollectionDays)
        CollectionDays.register(UINib(nibName: "DaysCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DayCell")
        tareastableview.register(UINib(nibName: "TaskTableViewCell", bundle: .main), forCellReuseIdentifier: "taskcell")
        tareastableview.delegate = self
        tareastableview.dataSource = self
        view.addSubview(tareastableview)
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        getdatetoday()
        loaddatatable()
    }
    func loaddatatable(){
        let result = tareasvfiewmodel.gettaskbyday(fecha: "05/04/2023")
        if result.Correct == true{
            tasks = result.Objects! as! [Tasck]
            tareastableview.reloadData()
        }
        else{
            alertfalse()
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func getdatetoday(){
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MMMM/yyyy"
        let dateString = dateformatter.string(from: date)
        Datetodaylbl.text = dateString
    }

    
    
    func loadData(){
        
        day =  tareasvfiewmodel.getdatename(mounth: 0, year: 0)
        CollectionDays.reloadData()

        

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        day.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath as! IndexPath) as! DaysCollectionViewCell
        cell.mounthlbl.text = day[indexPath.row].dayname
        cell.daylbl.text = day[indexPath.row].daynumber
        if day[indexPath.row].daynumber != String(daynumber){
            cell.daycellcolor.backgroundColor = .blue}
        else{
            cell.daycellcolor.backgroundColor = .purple
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        daynumber = day[indexPath.row].daynumber
        let totalCeldas = collectionView.numberOfItems(inSection: 0)
        for i in 0..<totalCeldas {
            var indexpathselect = IndexPath(item: i, section: 0)
            if let celda = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? DaysCollectionViewCell {
                if indexPath as IndexPath != indexpathselect{
                    celda.daycellcolor.backgroundColor = UIColor.blue // Cambia el color a tu preferencia
                }
                else {
                    celda.daycellcolor.backgroundColor = UIColor.purple
                }
            }
        }
            }
        
    
    func alertfalse(){
        let alert = UIAlertController(title: nil, message: "Ocurrio un error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func alerttru(){
        let alert = UIAlertController(title: nil, message: "Se agrego correctamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func addcategorie(){
        let alertcategorie = UIAlertController(title: nil, message: "Add Categorie", preferredStyle: .alert)
        alertcategorie.addTextField()
     let cancel =   UIAlertAction(title: "Cancel", style: .cancel)
        alertcategorie.addAction(cancel)
        alertcategorie.addAction(UIAlertAction(title: "Add", style: .default){action in
                let categoyname = alertcategorie.textFields![0] as UITextField
            let category = Category(idcategory: 0, namecategory: categoyname.text!)
            
            let result = self.tareasvfiewmodel.addCategorie(categoria: category)
            if result.Correct == true{
                self.alerttru()
            }
            else{
                self.alertfalse()
            }
        })
        
        self.present(alertcategorie, animated: true)
    }
    func alertsheet(){
        let alertsheet = UIAlertController(title: nil, message: "Select Option", preferredStyle: .actionSheet)
        alertsheet.addAction(UIAlertAction(title: "Add Categorie", style: .default){
            action in
            self.addcategorie()
            
        })
        
        alertsheet.addAction( UIAlertAction(title: "Add Task", style: .default){action in
            self.performSegue(withIdentifier: "seguesaddtask", sender: nil)
        })
        alertsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertsheet, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tasks.count)
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "taskcell", for: indexPath as IndexPath) as! TaskTableViewCell
     
        cel.tasktable.text = tasks[indexPath.row].Name
        cel.Timelbl.text = tasks[indexPath.row].Fecha
        return cel
    }
    
    
    
   
    @IBAction func addtaskaction(_ sender: Any) {
        alertsheet()

    }
    
    @IBAction func actionmenu(_ sender: Any) {
    }
    

}

