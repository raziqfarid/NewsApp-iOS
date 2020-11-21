//
//  DataSourceModel.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit

class HomeDataSourceModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /// Holds the list of articles
    var articles = [Article]()
    
    /// closure is called when a article is selected from table and the selected article is provided through this closure
    var selectedArticle: ((Article) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell()}
        cell.configureCell(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle?(articles[indexPath.row])
    }
}
