//
//  TagListTableViewController.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/08.
//

import UIKit
import NendAd

class TagListTableViewController: UITableViewController {

    var tags: [Tag] = []
    let tagsDao = TagDao()
    
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
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tagsDao.delete(tag: tags[indexPath.row])
        }
        reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.tableView.indexPathForSelectedRow != nil {
            let indexPath = self.tableView.indexPathForSelectedRow
            let nextView = segue.destination as! RegisterTagViewController
            nextView.targetEntity = tags[indexPath!.row]
        }
    }
    
    func reloadData() -> Void {
        tags = TagDao().getAll()
        tableView.reloadData()
    }
    
}
