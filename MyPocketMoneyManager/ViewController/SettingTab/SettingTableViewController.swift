//
//  SettingTableViewController.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import NendAd

class SettingTableViewController: UITableViewController, NADViewDelegate {

    @IBOutlet weak var tagCountLabel: UILabel!
    
    let tagsDao = TagDao()

    private var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "タグの登録や、編集、削除を行うことができます。"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tagCountLabel.text = String(tagsDao.getAll().count)
        NADInterstitial.sharedInstance().showAd(from: self)
    }

}
