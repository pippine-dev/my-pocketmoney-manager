//
//  HistoryYearUITableViewController.swift
//  MyPocketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/14.
//

import UIKit

class HistoryYearUITableViewController: UITableViewController {

    var yearList: [Int16] = []
    
    let spendingDao = SpendingDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath)
        cell.textLabel?.text = String(yearList[indexPath.row])
        return cell
    }

    func reloadData() {
        yearList = spendingDao.getAllYear()
        tableView.reloadData()
    }

}
