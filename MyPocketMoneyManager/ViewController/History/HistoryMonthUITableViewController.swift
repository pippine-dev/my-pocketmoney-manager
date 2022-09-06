//
//  HistoryMonthUITableViewController.swift
//  MyPocketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/21.
//

import UIKit
import NendAd

class HistoryMonthUITableViewController: UITableViewController {

    var targetYear: Int16 = 0
    var monthList: [Int16] = []
    
    let spendingDao = SpendingDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        NADInterstitial.sharedInstance().showAd(from: self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell", for: indexPath)
        cell.textLabel?.text = String(monthList[indexPath.row]) + "月"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow
        let nextView = segue.destination as! SpendingDetailViewController
        nextView.targetMonth = monthList[indexPath!.row]
        nextView.targetYear = targetYear
    }
    
    func reloadData() {
        monthList = spendingDao.getAllMonth(year: targetYear)
        tableView.reloadData()
    }

}
