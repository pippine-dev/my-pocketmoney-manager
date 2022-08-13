//
//  RegisterMoneyViewController.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import NendAd

class RegisterMoneyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var moneyTextField: UITextField!

    var selectedTag: Tag? = nil
    let pocketMoneyDao = SpendingDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyTextField.keyboardType = UIKeyboardType.numberPad
        moneyTextField.delegate = self
        moneyTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NADInterstitial.sharedInstance().showAd(from: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moneyTextField.resignFirstResponder()
    }
    
    @IBAction func clickSaveButton(_ sender: Any) {
        if selectedTag == nil {
            return
        }
        pocketMoneyDao.save(amount: Int32(moneyTextField.text!)!, tagName: selectedTag?.name)
        navigationController!.popViewController(animated: true)
    }

    @IBAction func clickMinusButton(_ sender: Any) {
        if moneyTextField.text != nil {
            pocketMoneyDao.save(amount: Int32(moneyTextField.text!)! * -Int32(1), tagName: selectedTag?.name)
            navigationController!.popViewController(animated: true)
        }
    }
    
}
