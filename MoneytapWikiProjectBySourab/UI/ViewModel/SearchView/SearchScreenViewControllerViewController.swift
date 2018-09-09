//
//  SearchScreenViewController.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class SearchScreenViewController: SuperViewController {

    var dlmWikiData : DLMWikiData?

    @IBOutlet weak var searchBarWiki: UISearchBar!
    @IBOutlet weak var tableViewWikiData: UITableView!
    @IBOutlet weak var activityIndicatorTableView: UIActivityIndicatorView!
    
    var arrAllPages: [Page] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.searchVCTitle
        setup()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setup() {
        dlmWikiData = DLMWikiData()
        activityIndicatorTableView.stopAnimating()
    }
    
    func setupTableView() {
        tableViewWikiData.register(UINib(nibName: Constants.wikiDataTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.wikiDataTableViewCellIdentifier)
        
        tableViewWikiData.estimatedRowHeight = 100.0
        tableViewWikiData.rowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: -Fetching WikiResults
    @objc func getWikiResults(withSearchKey: String) {
        WikiLog().print("Calling getWikiResults :: \(withSearchKey)")
        if Reachability.isConnectedToNetwork() {
            activityIndicatorTableView.startAnimating()
            dlmWikiData?.callWikiAPI(withSearchText: withSearchKey, successBlock: { (successObject : AnyObject) in
                WikiLog().print("Success of the API Call")
                self.handleSuccess()
            },
                                       failureBlock: { (failureObjcet : AnyObject) in
                                        WikiLog().print("failure of the API Call")
                                        self.handleFailure(failureObj: failureObjcet)
            }
            )
        } else {
            handleNetworkFailure()
        }
    }
    
    func handleSuccess() {
        activityIndicatorTableView.stopAnimating()
        reloadTableViewData()
    }
    
    func handleFailure(failureObj: AnyObject) {
        activityIndicatorTableView.stopAnimating()
        showAlert(withTitle: Constants.oopsTitle, alertMessage: Constants.genericFailureMessage, actionTitle: Constants.alertOkActionTitle)
    }
    
    func handleNetworkFailure() {
        showAlert(withTitle: Constants.oopsTitle, alertMessage: Constants.noInternetMessage, actionTitle: Constants.alertOkActionTitle)
    }
    
    func reloadTableViewData() {
        if let arrBu = dlmWikiData?.getAllWikiPages() {
            arrAllPages = arrBu
        } else {
            arrAllPages = []
        }
        tableViewWikiData.reloadData()
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, searchText.count > 0 else {
            arrAllPages = []
            tableViewWikiData.reloadData()
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(getWikiResults(withSearchKey:)), with: searchText, afterDelay: 0.4)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count > 0 else {
            arrAllPages = []
            tableViewWikiData.reloadData()
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(getWikiResults(withSearchKey:)), with: searchText, afterDelay: 0.4)
        searchBar.resignFirstResponder()
    }
}

extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCellForWikiResults(withTableView: tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableViewCellForWikiResults(withTableView tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cellWikiDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.wikiDataTableViewCellIdentifier, for: indexPath) as! WikiDataTableViewCell
        cellWikiDataTableViewCell.contentView.layoutIfNeeded()
        
        cellWikiDataTableViewCell.labelTitle.text = ""
        cellWikiDataTableViewCell.labelDescription.text = ""
        
        if let strPageTitle = arrAllPages[indexPath.row].title {
            cellWikiDataTableViewCell.labelTitle.text = strPageTitle
        }
        
        if let strPageDesc = arrAllPages[indexPath.row].terms?.description {
            if strPageDesc.count > 0 {
                cellWikiDataTableViewCell.labelDescription.text = strPageDesc[0]
            }
        }
        
        //Show image
        cellWikiDataTableViewCell.activityIndicatorImage.stopAnimating()
        if let imageSource = arrAllPages[indexPath.row].thumbnail?.source {
            cellWikiDataTableViewCell.loadImageWithImageUrl(strImgSource: imageSource)
        } else {
            cellWikiDataTableViewCell.imgVwWikiImage.image = UIImage.init(named: "imageNotFound")
        }
        
        if indexPath.row%2 == 0 {
            cellWikiDataTableViewCell.backgroundColor = UIColor.white
        } else {
            cellWikiDataTableViewCell.backgroundColor = BrandingClass.getCellAlternativeColor()
        }
        cellWikiDataTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        return cellWikiDataTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let wikiPageId = arrAllPages[indexPath.row].pageid else { return }
        let pageUrl = AppManager.sharedInstance.getWikiPageUrl() + String(wikiPageId)
        
        let customerSuccessStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = customerSuccessStoryBoard.instantiateViewController(withIdentifier: "WikiWebViewController") as! WikiWebViewController
        viewController.strWikiPageUrl = pageUrl
        viewController.strPageTitle = arrAllPages[indexPath.row].title
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchScreenViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBarWiki.resignFirstResponder()
    }
}

