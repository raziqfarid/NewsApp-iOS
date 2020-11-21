//
//  ViewController.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    /// Holds the tableView which displays the news
    @IBOutlet weak var tblView: UITableView!
    
    /// Holds the articles. tableview data source and delegates
    var dataSourceModel = HomeDataSourceModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getDataFromAPI()
    }
    
    /// Configures content Inset, Datasource, Delegate and handles selected article
    func configureTableView() {
        tblView.contentInset.top = 20
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tblView.dataSource = dataSourceModel
        tblView.delegate = dataSourceModel
        dataSourceModel.selectedArticle = { [weak self] (article) in
            self?.navigateToDetail(article: article)
        }
    }
    
    /// Gets the news from the api and sends to datasourcemodel
    func getDataFromAPI() {
        showLoader()
        APIService.shared.getNews { [weak self] (result) in
            self?.hideLoader()
            switch result {
            case .success(let articles):
                self?.dataSourceModel.articles = articles
                self?.tblView.reloadData()
            case .failure(let error):
                self?.showAlertMessage(message: error.localizedDescription)
            }
        }
    }
    
    /// Navigates to detail screen baseed on the selected article
    /// - Parameter article: selected article from table
    func navigateToDetail(article: Article) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController, let url = article.url else { return }
        controller.webUrl = url
        navigationController?.pushViewController(controller, animated: true)
    }
}
