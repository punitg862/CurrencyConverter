//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import UIKit

class ViewController: UIViewController {
        
    var localList = Array<String>()
    
    @IBOutlet weak var tblViewFrom: UITableView!
    @IBOutlet weak var tblViewTo: UITableView!

    @IBOutlet weak var buttonTo: UIButton!
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonDetails: UIButton!

    @IBOutlet weak var textfieldFrom: UITextField!
    @IBOutlet weak var textfieldTo: UITextField!

    var fromTblviewHidden = true {
        didSet {
            tblViewFrom.isHidden = fromTblviewHidden
            buttonDetails.isHidden = !fromTblviewHidden
        }
    }
    
    var toTblviewHidden = true {
        didSet {
            tblViewTo.isHidden = toTblviewHidden
            buttonDetails.isHidden = !toTblviewHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utillclass.shared.getJson { (list: Dictionary<String, Currencydetails>) in
            list.forEach { (key: String, value: Currencydetails) in
                self.localList.append(key)
            }
            self.localList = self.localList.sorted()
        }
        fromTblviewHidden = true
        toTblviewHidden = true
        addToolBar(textfield: textfieldFrom)
        addToolBar(textfield: textfieldTo)
    }
    
    @IBAction func btn_ToClicked(_ sender: UIButton) {
        fromTblviewHidden = true
        doneTapped()
        toTblviewHidden = !toTblviewHidden
    }
    
    @IBAction func btn_FromClicked(_ sender: UIButton) {
        toTblviewHidden = true
        doneTapped()
        fromTblviewHidden = !fromTblviewHidden
    }
    
    @IBAction func btn_SwapClicked(_ sender: UIButton) {
        let (fromStatus, btnFromText) = btnFromValidation()
        let (toStatus, btnToText) = btnToValidation()
        
        guard fromStatus, toStatus, btnFromText != btnToText else { return }
        guard let textFrom = textfieldFrom.text, !textFrom.isEmpty else { return }
        
        self.callService(from: btnToText!, to: btnFromText!, amount: textFrom, type: .TO)
        
        buttonFrom.setTitle(btnToText, for: .normal)
        buttonTo.setTitle(btnFromText, for: .normal)
    }
    
    @IBAction func btn_DetailsClicked(_ sender: UIButton) {
        let (fromStatus, btnFromText) = btnFromValidation()
        
        guard fromStatus else {
            Utillclass.shared.alertWithCustomMessage("Please select From field!", vc: self)
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoricalDataVC") as? HistoricalDataVC {
            vc.base = btnFromText!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    @IBAction func textFieldFromDidEnd(_ sender: UITextField) {
        if sender.text?.count ?? 0 == 0 {
            sender.text = "1"
        }
        
        let (fromStatus, btnFromText) = btnFromValidation()
        let (toStatus, btnToText) = btnToValidation()
        
        guard fromStatus, toStatus, btnFromText != btnToText else { return }
        
        self.callService(from: btnFromText!, to: btnToText!, amount: sender.text ?? "1", type: .TO)
    }
    
    @IBAction func textFieldToDidEnd(_ sender: UITextField) {
        if sender.text?.count ?? 0 == 0 {
            sender.text = "1"
        } else if sender.text == "xxxx" {
            
        }
        let (fromStatus, btnFromText) = btnFromValidation()
        let (toStatus, btnToText) = btnToValidation()
        
        guard fromStatus, toStatus, btnFromText != btnToText else { return }
        
        self.callService(from: btnToText!, to: btnFromText!, amount: sender.text ?? "1", type: .FROM)
    }
    
    @IBAction func textFieldFromTouchUpInside(_ sender: UITextField) {
        fromTblviewHidden = true
        toTblviewHidden = true
    }
}


//MARK :: Tableview DataSource AND Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currCell", for: indexPath)
        
        cell.textLabel?.text = self.localList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewFrom {
            buttonFrom.setTitle(self.localList[indexPath.row], for: .normal)
            fromTblviewHidden = true
            
            let (toStatus, btnToText) = btnToValidation()
            guard toStatus, let textFrom = textfieldFrom.text, !textFrom.isEmpty else { return }
            self.callService(from: self.localList[indexPath.row], to: btnToText!, amount: textFrom, type: .TO)
        } else {
            buttonTo.setTitle(self.localList[indexPath.row], for: .normal)
            toTblviewHidden = true
            let (fromStatus, btnFromText) = btnFromValidation()
            guard fromStatus, let textFrom = textfieldFrom.text, !textFrom.isEmpty else { return }
            self.callService(from: btnFromText!, to: self.localList[indexPath.row], amount: textFrom, type: .TO)
        }
        
        
    }
}

//MARK :: Button validation and Textfield delegate
extension ViewController: UITextFieldDelegate {
    
    func btnFromValidation() -> (Bool, String? ){
        guard let btnFromText = buttonFrom.titleLabel?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !btnFromText.isEmpty, btnFromText != "From" else { return (false,nil )}
        
        return (true,btnFromText)
    }
    
    func btnToValidation() -> (Bool, String? ){
        guard let btnToText = buttonTo.titleLabel?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !btnToText.isEmpty, btnToText != "To" else { return (false,nil) }
        
        return (true,btnToText )
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charSet = textField.text?.count ?? 0 > 0 ? "0123456789." : "123456789."
        let allowedCharacterSet = CharacterSet.init(charactersIn: charSet)
        let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
        if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
            return false
        }
        return true
    }
    
    func callService(from: String, to: String, amount: String, type: isType) {
        let param = Dictionary(dictionaryLiteral: ("from",from),("to", to),("amount",amount))
        print(param)
        ServiceCall.shared.getConvertionData(param: param) { response, status in
            if let response {
                DispatchQueue.main.async {
                    if type == .FROM {
                        self.textfieldFrom.text = String(format: "%.2f", Double(response.result))
                    }else {
                        self.textfieldTo.text = String(format: "%.2f", Double(response.result))
                    }
                }
            }
        }
    }
    
    func addToolBar( textfield: UITextField) {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexibleSpace,reset]
        bar.sizeToFit()
        textfield.inputAccessoryView = bar
    }
    
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    
    enum isType:String {
        case FROM = "from"
        case TO = "to"
    }
}
