//
//  RecipeListVC.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class RecipeListVC: BaseVC  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecords: UILabel!
    
    // MARK: - Properties
    private var viewModel = RecipeListViewModelImplementation()
    
    //MARK:- dataSource
    var dataSource: TableViewDataSource?{
        didSet{
            self.tableView.dataSource = dataSource
            self.tableView.delegate = dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noRecords.isHidden = true
        viewModel.fetchRecipes()
        reloadTable(with: viewModel.recipes)
    }
    
    func reloadTable(with items: [Recipe]?){
        self.dataSource?.items = items
        tableView.reloadData()
    }
}

// MARK: - setup tableview data source and delegate
extension RecipeListVC {
    
    func setupTableView() {
        dataSource = TableViewDataSource(items: viewModel.recipes, height: 160, tableView: tableView, cellIdentifier: .receipecell)
        dataSource?.configureCellBlock = {(cell,item,indexPath) in
            (cell as? ReceipeListCell)?.configureCell(recipe: item as? Recipe)
        }
        dataSource?.aRowSelectedListener = {[unowned self](indexPath) in
            self.performSegue(withIdentifier: SegueString.segueReceipeDetails, sender: indexPath.row)
        }
    }
}

// MARK: - Segue methods
extension RecipeListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueString.segueReceipeDetails {
            (segue.destination as? RecipeDetailVC)?.recipe = viewModel.recipes?[/(sender as? Int)]
        }
    }
}

// MARK: - Setup Picker Data Source & Delegate
extension RecipeListVC {
    private func setupPickerView() {
        self.pickerView.toolbarDelegate = self
        self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 200)
        self.pickerView.toolbar?.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 50)
        self.pickerView.toolbar?.backgroundColor = .white
        self.pickerView.backgroundColor = .white
        self.view.addSubview(pickerView)
        self.view.addSubview(self.pickerView.toolbar!)
        var cateogryArray = self.categoryArray?.map({$0.name})
        cateogryArray?.insert("All", at: 0)
        pickerDataSource = PickerDataSource(items: cateogryArray, pickerView: pickerView)
    }
}

// MARK: - Picker Delegate
extension RecipeListVC: PickerViewDelegate {
    
    func doneButtonClicked() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        let category = self.categoryArray
        let name = row == 0 ? "" : category?[row - 1].name
        let arrayToReload = name == "" ? viewModel.recipes : viewModel.recipes?.filter({$0.category == name})
        self.reloadTable(with: arrayToReload)
        self.noRecords.isHidden = arrayToReload?.count != 0
        self.updatePickerViewWith(false)
    }
    
    func cancelButtonClicked() {
        self.updatePickerViewWith(false)
    }
}

// MARK: - IBOutlet actions
extension RecipeListVC{
    @IBAction func filterButtonAction(_ sender: Any) {
        self.updatePickerViewWith(true)
    }
    
    func updatePickerViewWith(_ animatation: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: animatation ? self.view.bounds.height-200 : self.view.bounds.height, width: self.view.bounds.width, height: 200)
            self.pickerView.toolbar?.frame = CGRect(x: 0, y: animatation ? self.view.bounds.height-250 : self.view.bounds.height, width: self.view.bounds.width, height: 50)
            self.view.layoutIfNeeded()
        }) { (isComplete) in
            
        }
    }
}
