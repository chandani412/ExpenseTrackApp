//
//  AddExpense.swift
//  ExpenseTrackerApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class AddExpense: UIViewController, SelectedCatDelegate,UITextFieldDelegate, UIGestureRecognizerDelegate {
   
    

    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var expenceTitle : UITextField!
    @IBOutlet weak var expenceAmount : UITextField!
    @IBOutlet weak var expenceNotes : UITextField!
    @IBOutlet weak var expenceDate : UITextField!
    @IBOutlet weak var expenceCategory : UITextField!
    
    @IBOutlet weak var datePicker : UIDatePicker!
    
    let db = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expenceTitle.setLeftPaddingPoints(10)
        expenceAmount.setLeftPaddingPoints(10)
        expenceNotes.setLeftPaddingPoints(10)
        expenceDate.setLeftPaddingPoints(10)
        expenceCategory.setLeftPaddingPoints(10)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(tap:)))
        gesture.delegate = self
        gesture.numberOfTapsRequired = 1
        expenceDate.addGestureRecognizer(gesture)
        
        
        var gesture1 = UITapGestureRecognizer(target: self, action: #selector(catClick(_:)))
        gesture1.delegate = self
        gesture1.numberOfTapsRequired = 1
        expenceCategory.addGestureRecognizer(gesture1)
    }
    @objc func tapGesture(tap:UITapGestureRecognizer)  {
        
        datePicker.isHidden = false
    }
    func setCategory(cat: String) {
        expenceCategory.text = cat
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == expenceDate {
            return false
        }
        if textField == expenceCategory {
            return false
        }
        return true
    }
    //MARK: - Textfield Delegates
    
    @IBAction func saveClick(_ sender: Any) {
        
        if expenceTitle.text != "" && expenceDate.text != "" &&  expenceAmount.text != "" && expenceCategory.text != "" {
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
           
           
           let managedContext = appDelegate!.persistentContainer.viewContext
            
            let object = Expense.init(context: managedContext)
            object.title = expenceTitle.text!
            object.amount = expenceAmount.text!
            object.date = expenceDate.text!
            object.notes = expenceNotes.text!
            object.category = expenceCategory.text!
            
            db.createData(data: object)
            
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.view.makeToast("Please enter all fields")
        }
    }
    @IBAction func dateValChange(_ sender: Any) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        expenceDate.text = formatter.string(from: datePicker.date)
        
        datePicker.isHidden = true
    }
    @IBAction func backClick(_ sender: Any) {
    }
    @IBAction func catClick(_ sender: Any) {
        
       
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "CatList") as! CatList
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.catobj = self
             
        self.present(vc, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    @objc  func keyboardWillShow(notification:NSNotification) {
        print("keyboardWillShow")
           guard let userInfo = notification.userInfo else { return }
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)

           var contentInset:UIEdgeInsets = self.scrollView.contentInset
           contentInset.bottom = keyboardFrame.size.height + 20
           scrollView.contentInset = contentInset
       }

    @objc  func keyboardWillHide(notification:NSNotification) {
           print("keyboardWillHide")
//           let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//           scrollView.contentInset = contentInset
           guard let userInfo = notification.userInfo else { return }
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)

           var contentInset:UIEdgeInsets = self.scrollView.contentInset
           contentInset.bottom =   -80
           scrollView.contentInset = contentInset
       }
    
    
    
    
    
    
   
    
   
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
