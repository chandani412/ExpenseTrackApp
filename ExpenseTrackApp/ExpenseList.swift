//
//  ExpenseList.swift
//  ExpenseTrackerApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit
import CoreData

class ExpenseList: UIViewController ,UITableViewDelegate,UITableViewDataSource, FilterSelectDelegate{
    
    

    @IBOutlet weak var expenseTbl: UITableView!
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    
    
    var db = DataBase()
    var expenseArr : [NSManagedObject]!
//    var expenseArr = [NSManagedObject]?.self
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        expenseArr =  db.retrieveData()
    
        expenseTbl.reloadData()
        
        if expenseArr.count == 0 {
            filterBtn.image = UIImage(named: "")
        }
        else{
            filterBtn.image = UIImage(named: "filter_icon")
        }
    }
    @IBAction func filterClick(_ sender: Any) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterView") as! FilterView
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.filterobj = self
             
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func addClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddExpense") as! AddExpense
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - UITableview Datasource and Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
            return expenseArr.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = expenseTbl.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseCell

            let object = expenseArr[indexPath.row] as! Expense
          

            
            cell.expenceTitle.text = object.title!
            cell.expenceAmount.text = object.amount!
            cell.expenceDate.text = object.date!
            cell.expenceNotes.text = object.notes!
            cell.expenceCategory.text = object.category!
            
            
            
          
            
            return cell
           
            
            
   

            return cell
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Custom Delegates
    
    func filterCatselected(value: String)
    {
        expenseArr = db.retrieveDataByCategory(value: value)
        expenseTbl.reloadData()
        
    }
    

    
    func dateSelected(fromDate:String,toDate:String)
    {
        expenseArr = db.retrieveDataByDate(startDate: fromDate, toDate: toDate)
        expenseTbl.reloadData()
    }
    
    

}
