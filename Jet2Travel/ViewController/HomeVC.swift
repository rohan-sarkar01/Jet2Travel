//
//  HomeVC.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 19/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var articleViewModel = ArticleViewModel()
    var pageNumber = 1
    let limit = 10
    var isLoadingList: Bool = false
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblLoading: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initializeNavBar()
        self.tableview.tableFooterView = UIView()
        self.lblLoading.isHidden = true
        if self.appdelegate.getAllArticles().count == 0
        {
            self.loadArticles(pageNumber: self.pageNumber)
        }
        else
        {
            self.tableview.reloadData()
        }
        
    }
    
    func initializeNavBar()
    {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "HeaderNav")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        self.navigationController!.navigationBar.isTranslucent = false
    }
    
    func loadArticles(pageNumber: Int)
    {
        self.lblLoading.isHidden = false
        self.lblLoading.text = "Loading..."
        let params :[String: Any] = [:]
        let urlPath = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pageNumber)&limit=\(limit)"
        self.articleViewModel.loadSectionsList(params, urlString: urlPath) { (networkStatus, success, error) in
            self.lblLoading.isHidden = true
            if networkStatus == "false"
            {
                self.lblLoading.isHidden = false
                self.lblLoading.text = "No Network Connection"
            }
            else
            {
                if success == "1"
                {
                    self.isLoadingList = false
                    self.tableview.reloadData()
                }
                else
                {
                    print("Something went wrong.")
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.appdelegate.getAllArticles().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "cell") as! ArticleCell
        let info = self.appdelegate.getAllArticles()[indexPath.row]
        cell.configureCell(info: info)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    //MARK: scrollview delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        isLoadingList = false
    }

    //scrollview delegate method for pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if ((self.tableview.contentOffset.y + self.tableview.frame.size.height) >= self.tableview.contentSize.height)
        {
            if !isLoadingList
            {
                isLoadingList = true
                loadMoreData()
            }
        }
    }
    
    //call function for pagination
    func loadMoreData()
    {
        self.isLoadingList = true
        pageNumber = pageNumber + 1
        loadArticles(pageNumber: pageNumber)
    }
}
