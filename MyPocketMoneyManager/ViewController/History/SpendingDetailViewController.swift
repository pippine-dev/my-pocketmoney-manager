//
//  SpendingDetailViewController.swift
//  MyPocketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/21.
//

import UIKit
import NendAd

class SpendingDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tagsAmountTableView: UITableView!
    
    var targetYear: Int16 = 0
    var targetMonth: Int16 = 0
    
    let spendingDao: SpendingDao = SpendingDao()
    var tagsAmount: [SpendingDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagsAmountTableView.delegate = self
        self.tagsAmountTableView.dataSource = self
        self.title = String(targetYear) + "年" + String(targetMonth) + "月支出"
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        NADInterstitial.sharedInstance().showAd(from: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tagsAmount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagAmountCell", for: indexPath)
        cell.textLabel?.text = tagsAmount[indexPath.row].tagName
        cell.detailTextLabel?.text = "¥" + String.localizedStringWithFormat("%d", tagsAmount[indexPath.row].totalAmount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tagsAmountTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func reloadData() {
        self.tagsAmount = spendingDao.getTotalAmountPerTags(year: targetYear, month: targetMonth)
        var totalAmount = 0
        for tagAmount in tagsAmount {
            totalAmount += Int(tagAmount.totalAmount)
        }
        self.totalAmountLabel.text = "¥" + String.localizedStringWithFormat("%d", totalAmount)
        self.tagsAmountTableView.reloadData()
    }
    
}
