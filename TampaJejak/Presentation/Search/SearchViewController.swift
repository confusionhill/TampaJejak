//
//  SearchViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 28/05/22.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private(set) weak var delegate: CategoryDelegate?
    var viewModel: SearchViewModel!
    
    init(foods: [FoodModel], delegate: CategoryDelegate) {
        super.init(nibName: "SearchViewController", bundle: nil)
        SearchViewModel.config(vc: self, foods: foods)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Search"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension SearchViewController: SearchViewModelOutput {
    func setupViews() {
        self.setupSearchBar()
        self.setupTableView()
    }
    
    func didFinnishFilter() {
        self.tableView.reloadData()
        
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: OrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did tap cell")
        let model = viewModel.foods[indexPath.row]
        self.delegate?.didTapCell(foodModel: model)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        let model = viewModel.foods[indexPath.row]
        cell.setupRegularContent(foodModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.row
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterFood(textInput: searchBar.text ?? "")
    }
}
