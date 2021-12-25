//
//  CatList.swift
//  ExpenseTrackApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class CatList: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var catTbl:UITableView!
    var catArr  = NSMutableArray()
    var catobj : SelectedCatDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        catArr.add("Food")
        catArr.add("Shoping")
        catArr.add("Sports")
        catArr.add("Electronics")
        
        // Do any additional setup after loading the view.
    }
    //MARK: - IBAction
    @IBAction func cancelClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    //MARK: - UITableview Datasource and Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           
                return catArr.count
           
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = catTbl.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

           // cell.textLabel?.textAlignment = NSTextAlignment.center
           
            
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = catArr.object(at: indexPath.row) as? String
            
            
            return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let str = catArr.object(at: indexPath.row) as! String
            catobj?.setCategory(cat: str)
            self.dismiss(animated: true, completion: nil)
            
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
protocol SelectedCatDelegate { //
    func setCategory(cat: String)
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


