//
//  FilterView.swift
//  ExpenseTrackerApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class FilterView: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate {
    
    
    var isSubMenu = Bool()
    var isDateFilter = Bool()
    var mainMenuArray = NSMutableArray()
    var subMenuArray = NSMutableArray()
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var txtFromDate: UITextField!
    @IBOutlet var txtToDate: UITextField!
    @IBOutlet var viewDate: UIView!
    @IBOutlet var tblFilter: UITableView!

    
    var filterobj : FilterSelectDelegate!


    override func viewDidLoad() {
        super.viewDidLoad()

        viewDesign()
    }
    
    func viewDesign()  {
        
        mainMenuArray.addObjects(from:[ "Date","Category"])
        isSubMenu = false
        
        txtFromDate.setLeftPaddingPoints(10)
    
        txtToDate.setLeftPaddingPoints(10)
        
        
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(tap:)))
        gesture.delegate = self
        gesture.numberOfTapsRequired = 1
        txtFromDate.addGestureRecognizer(gesture)
        
        var gesture1 = UITapGestureRecognizer(target: self, action: #selector(tapGesture1(tap:)))
        gesture1.delegate = self
        gesture1.numberOfTapsRequired = 1
        
        txtToDate.addGestureRecognizer(gesture1)
        
        
        
    }

    @objc func tapGesture(tap:UITapGestureRecognizer)  {
        
        datePicker.isHidden = false
        datePicker.tag = 0
    }
    
    @objc func tapGesture1(tap:UITapGestureRecognizer)  {
        
        datePicker.isHidden = false
        datePicker.tag = 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSubMenu {
            return subMenuArray.count
        }
        else
        {
            return mainMenuArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tblFilter.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        if isSubMenu {
            
            cell.textLabel!.text = subMenuArray[indexPath.row] as? String
            cell.accessoryType = .none

        }
        else
        {
            cell.textLabel!.text = mainMenuArray.object(at: indexPath.row) as? String
            cell.accessoryType = .disclosureIndicator
        }
        
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSubMenu {
            
            isSubMenu = false
            
            if isDateFilter {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-YYYY"
                
                if indexPath.row == 0 {
                    
        
                    filterobj.dateSelected(fromDate:formatter.string(from: Date()), toDate:formatter.string(from: Date()))
                    self.dismiss(animated: true, completion: nil)

                }
                else if indexPath.row == 1 {
                    
                    let sevenday = Calendar.current.date(byAdding: .day, value: -7, to: Date()) as! Date
                                                         
                    filterobj.dateSelected(fromDate:formatter.string(from: Date()), toDate:formatter.string(from:sevenday))
                    self.dismiss(animated: true, completion: nil)

                }
                else if indexPath.row == 2 {
                    
                   
                    
                    let firstDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
                                                         
                    filterobj.dateSelected(fromDate: formatter.string(from:firstDay), toDate: formatter.string(from:Date()))
                    self.dismiss(animated: true, completion: nil)

                }
                else if indexPath.row == 3 {
                    
                    viewDate.isHidden = false
                    tblFilter.isHidden = true
                    
                }
                
                
            }
            else
            {
                filterobj.filterCatselected(value: subMenuArray[indexPath.row] as! String)
                self.dismiss(animated: true, completion: nil)

            }
            
            tblFilter.reloadData()
        }
        else
        {
            isSubMenu = true
            if indexPath.row == 0 {
                subMenuArray = ["daily","weekly","monthly","custom"]
                isDateFilter = true

            }
            else
            {
                subMenuArray = ["Food","Shopping","Electronics","Sports"]
                isDateFilter = false

            }
            tblFilter.reloadData()
        }
        
    }
    
    
    @IBAction func datePicker_valueChange(_ sender: Any) {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        
        if datePicker.tag == 0 {
            txtFromDate.text = formatter.string(from: datePicker.date)
        }
        else
        {
            txtToDate.text =  formatter.string(from: datePicker.date)
        }
        
        

        datePicker.isHidden = true
    }
    
    
    @IBAction func done_click(_ sender: Any) {
        
        viewDate.isHidden = true
        
        filterobj.dateSelected(fromDate: txtFromDate.text!, toDate: txtToDate.text!)
        self.dismiss(animated: true, completion: nil)

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    
}

protocol FilterSelectDelegate {
   
    func filterCatselected(value: String)

    func dateSelected(fromDate:String,toDate:String)
}
