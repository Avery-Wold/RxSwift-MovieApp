//
//  SearchViewController.swift
//  AverysRxSwiftMovie
//
//  Created by AveryW on 2/23/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchTableViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    private let cellIdentifier = "CellIdentifier"
    private let appTitle = "Movie Search"
    private let minimumCharacterCount = 2
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBinding()
    }
    
    fileprivate func configureUI() {
        title = appTitle
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    fileprivate func configureBinding() {
        // Use the search bar to get data and bind it to the tableview
        searchController.searchBar.rx.text.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter{ query in
                return query!.count >= self.minimumCharacterCount
            }
            .map { ($0 ?? "").lowercased() }
            .map { MovieRequest(title: $0) }
            .flatMapLatest { request -> Observable<[Movie]> in
                return self.apiClient.send(apiRequest: request )
            }
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                if model.adult == false {
                    cell.textLabel?.text = model.title
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                }
            }
            .disposed(by: disposeBag)
        
        // Select cell to navigate to details
        tableView.rx.modelSelected(Movie.self).subscribe(onNext: { item in
            let controller = MovieDetailsViewController()
            controller.movie = item
            self.navigationController?.pushViewController(controller, animated: true)
        }).disposed(by: disposeBag)
    }
}
