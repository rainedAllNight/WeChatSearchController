//
//  AddressBookTableViewController.swift
//  WeChatSearchDemo
//
//  Created by 罗伟 on 2017/8/1.
//  Copyright © 2017年 rainedAllNight. All rights reserved.
//

import UIKit

class AddressBookTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    lazy var contactModels: [ContactModel] = {
        let models = "abcdefghijklmnopqrstuvwxyz".characters.map { (char) -> ContactModel in
            let model = ContactModel()
            model.name = String(char)
            return model
        }
        return models
    }()
    var searchController: UISearchController?
    var resultsController: SearchResultViewController?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private method
    
    fileprivate func addSearchController() {
        resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.sizeToFit()
        resultsController?.searchBar = searchController.searchBar
        resultsController?.reallyNavigationController = self.navigationController
        self.configSearchBar(searchController.searchBar)
        self.searchController = searchController
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    fileprivate func configSearchBar(_ searchBar: UISearchBar) {
        searchBar.tintColor = UIColor.init(colorLiteralRed: 22/255.0, green: 161/255.0, blue: 1/255.0, alpha: 1.0)
        searchBar.searchBarStyle = .prominent
        searchBar.setBackgroundImage(UIImage.imageWithColor(UIColor.init(red: 235/255.0, green: 235/255.0, blue: 242/255.0, alpha: 1.0)), for: .any, barMetrics: .default)
        searchBar.showsSearchResultsButton = true
        searchBar.setImage(#imageLiteral(resourceName: "VoiceSearchStartBtn"), for: .resultsList, state: .normal)
        searchBar.delegate = self
        
        let bgImage = #imageLiteral(resourceName: "widget_searchbar_textfield").resizableImage(withCapInsets: UIEdgeInsetsMake(10, 10, 10, 10))
        searchBar.setSearchFieldBackgroundImage(bgImage, for: .normal)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        cell.configCell(self.contactModels[indexPath.row])
        return cell
    }

    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        let resultViewController = searchController.searchResultsController as? SearchResultViewController
        // 简单的模拟下查询功能
        resultsController?.resultModels = self.contactModels.filter({ (model) -> Bool in
            if model.name == self.searchController?.searchBar.text || model.name == self.searchController?.searchBar.text?.lowercased() {
                return true
            } else {
                return false
            }
        })
        resultViewController?.tableView.reloadData()
    }
    
    // MARK: - UISearchControllerDelegate
    
    func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchController?.searchResultsController?.view.isHidden = false
        }
    }

    // MARK: - UISearchBarDelegate
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("该说话了")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchController?.searchResultsController?.view.isHidden = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.searchController?.searchResultsController?.view.isHidden = false
            }
        }
    }

}

extension UIView {
    func findSubView(_ className: AnyClass?) -> AnyObject? {
        guard let className = className else {
            return nil
        }
        
        for subView in self.subviews {
            if subView.isMember(of: className) {
                return subView
            } else {
                if let obj = subView.findSubView(className) , obj.isMember(of: className){
                    return obj
                }
            }
        }
        return nil
    }
}
