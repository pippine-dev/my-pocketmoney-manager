//
//  RegisterTagViewController.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/08.
//

import UIKit
import NendAd

class RegisterTagViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tagTextField: UITextField!

    var targetEntity: Tag? = nil
    let tagsDao = TagDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTextField.delegate = self
        tagTextField.becomeFirstResponder()
        if targetEntity != nil {
            tagTextField.text = targetEntity?.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NADInterstitial.sharedInstance().showAd(from: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tagTextField.resignFirstResponder()
    }
    
    @IBAction func clickRegisterButton(_ sender: Any) {
        if tagTextField.text != "" {
            if targetEntity == nil {
                if !tagsDao.existsTag(tagName: tagTextField.text!) {
                    let order: Int16 = Int16(TagDao().getAll().count) + 1
                    tagsDao.save(name: tagTextField.text!, order: order)
                } else {
                    let alert = UIAlertController(title: "エラー", message: "指定されたタグ名は既に登録されています。", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                }
            } else {
                tagsDao.update(entity: targetEntity!, newName: tagTextField.text!)
            }
        }
        navigationController!.popViewController(animated: true)
    }
    
}
