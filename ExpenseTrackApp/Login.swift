//
//  Login.swift
//  ExpenseTrackerApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class Login: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var passTxt : UITextField!
    @IBOutlet weak var confirmPassTxt : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passTxt.setLeftPaddingPoints(10)
        confirmPassTxt.setLeftPaddingPoints(10)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
    @IBAction func skipClick(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: isUserSkip)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpenseList") as! ExpenseList
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginClick(_ sender: Any) {
        let pascodeStr = passTxt.text!
        let confirmPasscodeStr = confirmPassTxt.text!
        
        if pascodeStr != "" && confirmPasscodeStr != "" {
            
           
            
            if pascodeStr == confirmPasscodeStr {
                
                UserDefaults.standard.setValue(true, forKey: isUserLogin)
               
               
    
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpenseList") as! ExpenseList
                
                
                self.navigationController?.pushViewController(vc, animated: true)

            }
            else
            {
                
                self.view.makeToast("Passcode and Confirm Should be same")
            }
      
        }
        else
        {
            self.view.makeToast("Please Enter value or Skip")
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
