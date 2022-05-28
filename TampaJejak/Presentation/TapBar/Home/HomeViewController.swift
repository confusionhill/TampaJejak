//
//  HomeViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapExit()
}

protocol HomeViewControllerOutput: AnyObject {
    func didTapFood(foodID id: String)
    func didTapFood(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    
    var viewModel: HomeViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        HomeViewModel.config(vc: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        HomeViewModel.config(vc: self)
    }
    
    lazy var tableviewHeader: HeaderView = {
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 25))
        return header
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupCart()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCartButton(_ sender: UIButton) {
        let vc = CartViewController(nibName: "CartViewController", bundle: nil)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .baseColor
        tableView.sectionHeaderTopPadding = 0
        tableView.shouldScrollSectionHeaders = true
        tableView.register(
            UINib(nibName: HomeHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HomeHeaderTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(
            UINib(nibName: CarouselTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CarouselTableViewCell.identifier)
        tableView.register(UINib(nibName: PlainCarouselTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlainCarouselTableViewCell.identifier)
        tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setupCart() {
        cartButton.setTitle(" ", for: .normal)
        cartButton.setImage(
            UIImage(
                systemName: "cart.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            for: .normal)
        self.cartButton.setCircular()
    }
}

extension HomeViewController: HomeViewModelOutput {
    func didFinnishLoadingForYou() {
        self.tableView.reloadData()
    }
    
    func didFinnishLoadingTopPicks() {
        self.tableView.reloadData()
    }
    
    func didFailLoading(message: String) {
        self.showSnackbar(message: message)
    }
    
    func setupViews() {
        self.setupTableView()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 3 {
            let vc = FoodCategoryViewController(loadFood: nil)
            vc.delegate = self
            let navCon = UINavigationController(rootViewController: vc)
            navCon.modalPresentationStyle = .fullScreen
            self.present(navCon, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.isLoaded {
            return 4
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeHeaderTableViewCell.identifier, for: indexPath) as! HomeHeaderTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier, for: indexPath) as! CarouselTableViewCell
            cell.selectionStyle = .none
            cell.homeOutput = self
            cell.foods = viewModel.foodModels
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlainCarouselTableViewCell.identifier, for: indexPath) as! PlainCarouselTableViewCell
            cell.selectionStyle = .none
            cell.homeOutput = self
            cell.foods = viewModel.foodModels
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.backgroundColor = .clear
            cell.layer.backgroundColor = UIColor.clear.cgColor
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return nil }
        if section == 1 { return  "Top Picks" }
        if section == 2 { return "For You" }
        return "Category"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let newView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        newView.title.text = self.tableView(tableView, titleForHeaderInSection: section) ?? ""
        return newView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return UITableView.automaticDimension
    }
}


extension HomeViewController: HomeViewControllerOutput {
    func didTapFood(foodID id: String) {
        print("not used")
    }
    
    func didTapFood(indexPath: IndexPath) {
        print(viewModel.foodModels[indexPath.row].uuid)
        let model = viewModel.foodModels[indexPath.row]
        let vc = FoodCategoryViewController(loadFood: model)
        vc.delegate = self
        let navCon = UINavigationController(rootViewController: vc)
        navCon.modalPresentationStyle = .fullScreen
        self.present(navCon, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func didTapExit() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: HomeHeaderDelegate {
    func didTapSearch() {
        let vc = FoodCategoryViewController(loadSearch: true)
        vc.delegate = self
        let navCon = UINavigationController(rootViewController: vc)
        navCon.modalPresentationStyle = .fullScreen
        self.present(navCon, animated: true, completion: nil)
    }
}
