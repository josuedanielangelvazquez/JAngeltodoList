//
//  seguesViewController.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 03/04/23.
//

import UIKit

class seguesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var Viewtimestart: UIStackView!
    @IBOutlet weak var Viewtimeend: UIStackView!
    @IBOutlet weak var Viewbotton: UIView!
    @IBOutlet weak var Addtasktext: UITextField!
    
    @IBOutlet weak var DateDay: UIDatePicker!
    @IBOutlet weak var Timestart: UIDatePicker!
    @IBOutlet weak var Timeend: UIDatePicker!
    @IBOutlet weak var Categorydate: UIPickerView!
    var tareasviewmodel = TareasViewModel()
    var categories = [Category]()
    var idcategory = 1
    let color = UIColor.white
    
 
    override func viewDidLoad() {
//        cambio de color de placeholder
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color]
        let attributedPlaceholder = NSAttributedString( string: "Write the Task", attributes: attributes)
        Addtasktext.attributedPlaceholder = attributedPlaceholder
//        termina edicion placeholder
        self.navigationController?.navigationBar.tintColor = UIColor.white
        Categorydate.dataSource = self
              Categorydate.delegate = self
        super.viewDidLoad()
        styles()

    }
    override func viewWillAppear(_ animated: Bool) {
        loaddatapicker()
    }
    
    func styles(){
        Addtasktext.layer.cornerRadius = 10
        Viewtimestart.layer.cornerRadius = 40
        Viewtimeend.layer.cornerRadius = 40
        View1.layer.cornerRadius = 30
        Viewbotton.layer.cornerRadius = 30
    }
    func loaddatapicker(){
        var result =   tareasviewmodel.geatllCategories()
        if result.Correct == true{
            categories = result.Objects! as! [Category]
        }
        else{
            print(result.ErrorMessage)
        }
    }
    func alerttrue(){
        let alert = UIAlertController(title: nil, message: "Se agrego correctamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func alertfalse(){
        let alert = UIAlertController(title: nil, message: "Ocurrio un error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func alertfalseequalsdatye(){
        let alert = UIAlertController(title: nil, message: "The start time cannot be equal to the end time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func getdate()->String{
     let dateformatte = DateFormatter()
        dateformatte.dateFormat = "dd/MM/yyyy"
        let stringformat: String = dateformatte.string(from: self.DateDay.date) as String
        return stringformat
    }
    func alertfalsetime(){
        let alert = UIAlertController(title: nil, message: "start time cannot be greater than end time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    func valtime()->Bool{
        var timestartisgreater = true
        if Timestart.date == Timeend.date{
            alertfalseequalsdatye()
        }
        else if Timestart.date > Timeend.date{
            timestartisgreater = false
        }
        else{
            timestartisgreater = true
        }
        return timestartisgreater
    }
    func getstarttime()->String{
        let dateformattestart = DateFormatter()
        dateformattestart.dateFormat = "HH:mm"
        let stringformat : String = dateformattestart.string(from: self.Timestart.date) as String
        return stringformat
    }
    func getendtime()->String{
        let dataformattedend = DateFormatter()
        dataformattedend.dateFormat = "HH:mm"
        let stringformat : String = dataformattedend.string(from: self.Timeend.date) as String
        return stringformat
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row].namecategory
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        idcategory  = categories[row].idcategory
        print(idcategory)
      }
    func addtask(){
        
        guard let name = Addtasktext.text, Addtasktext.text != nil, Addtasktext.text != "" else{
            Addtasktext.backgroundColor = .red
            return
        }
        if valtime() == true{
            
            let task = Tasck(idtask: 0, Name: name, HoraInicio: getstarttime(), HoraTermino: getendtime(), IdCategori: idcategory, Fecha: getdate())
            let result = tareasviewmodel.addtask(task: task)
            if result.Correct ==  true{
                alerttrue()
            }
            else{
                alertfalse()
            }
            
            
        }
        else{
            alertfalsetime()
        }
    }

    @IBAction func AddTask(_ sender: Any) {
        addtask()
    }
    

}
