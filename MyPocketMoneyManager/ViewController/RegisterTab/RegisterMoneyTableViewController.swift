//
//  RegisterMoneyTableViewController.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import NendAd

class RegisterMoneyTableViewController: UITableViewController {

    var tags: [Tag] = []
    let pocketMoneyDao = SpendingDao()
    let tagsDao = TagDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes
        = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0, weight: UIFont.Weight.bold)]
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        NADInterstitial.sharedInstance().showAd(from: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "タグ"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tag = tags[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = tag.name
        cell.detailTextLabel?.text = "¥" + String.localizedStringWithFormat("%d", pocketMoneyDao.getAmountWithTag(tagName: tag.name!))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow
        let nextView = segue.destination as! RegisterMoneyViewController
        nextView.selectedTag = tags[indexPath!.row]
    }
    
    func reloadData() -> Void {
        tags = tagsDao.getAll()
        let totalAmount = pocketMoneyDao.getTotalAmountThisMonth()
        let formattedAmount = String.localizedStringWithFormat("%d", totalAmount)
        self.navigationItem.title = "¥" + formattedAmount
        navigationItem.prompt = "今月残り" + String(DateUtils().getRemainDays()) + "日"
        self.tableView.reloadData()
    }
    
}
