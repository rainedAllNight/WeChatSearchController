//
//  SearchResultViewController.swift
//  WeChatSearchDemo
//
//  Created by 罗伟 on 2017/8/1.
//  Copyright © 2017年 rainedAllNight. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar?
    var resultModels = [ContactModel]()
    var reallyNavigationController: UINavigationController?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultModels.count > 0 ? self.resultModels.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.resultModels.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
            cell.configCell(self.resultModels[indexPath.row])
            return cell
            
        } else {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultPromptCell", for: indexPath)
            return cell
        }
    }
   
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.resultModels.count > 0 ? 44 : 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.resultModels.count > 0 {
            let detailViewController = UIViewController()
            detailViewController.title = self.resultModels[indexPath.row].name
            detailViewController.view.backgroundColor = UIColor.white
            self.reallyNavigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar?.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
