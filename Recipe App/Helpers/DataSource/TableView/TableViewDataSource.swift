//
//  TableViewDataSource.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//


import UIKit

typealias  ListCellConfigureBlock = (_ cell : Any , _ item : Any? , _ indexpath: IndexPath) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()
typealias  ScrollViewDidScroll = (_ scrollView : UIScrollView) -> ()
typealias  ViewForHeaderInSection = (_ section : Int) -> UIView?
typealias  WillDisplayTableViewCellBlock = (_ cell : UITableViewCell , _ indexpath : IndexPath) -> ()

//TableViewDataSource
class TableViewDataSource: NSObject  {
    
    var items : Array<Any>?
    private var cellIdentifier : String?
    private var tableView  : UITableView?
    private var tableViewRowHeight : CGFloat = 44.0
    
    var configureCellBlock: ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var ScrollViewListener : ScrollViewDidScroll?
    var viewforHeaderInSection : ViewForHeaderInSection?
    var headerHeight : CGFloat? = 0.0
    var willDisplayCell: WillDisplayTableViewCellBlock?
    
    //init method
    init (items : Array<Any>? , height : CGFloat , tableView : UITableView? , cellIdentifier : CellIdentifiers?) {
        self.tableView = tableView
        self.items = items
        self.cellIdentifier = cellIdentifier?.rawValue
        self.tableViewRowHeight = height
    }
    
    override init() {
        super.init()
    }
    
}

//TableView - DataSource Delegate methods
extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let block = configureCellBlock , let item: Any = items?[indexPath.row]{
            block(cell , item , indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return /items?.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let block = willDisplayCell{
            block(cell, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = aRowSelectedListener{
            block(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let block = viewforHeaderInSection else { return nil }
        return block(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return /headerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  200.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
