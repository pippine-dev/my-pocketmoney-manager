//
//  HistoryYearUITableViewController.swift
//  MyPocketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/14.
//

import UIKit
import NendAd

class HistoryYearUITableViewController: UITableViewController {

    var yearList: [Int16] = []
    
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
        return yearList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath)
        cell.textLabel?.text = String(yearList[indexPath.row]) + "年"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow
        let nextView = segue.destination as! HistoryMonthUITableViewController
        nextView.targetYear = yearList[indexPath!.row]
    }
    
    func reloadData() {
        yearList = spendingDao.getAllYear()
        tableView.reloadData()
    }

}
