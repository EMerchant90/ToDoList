//
//  GroupingTVController.swift
//  ToDoList
//
//  Created by Ejaz Merchant on 3/5/18.
//  Copyright © 2018 Ejaz Merchant. All rights reserved.
//

import UIKit
import RealmSwift

class GroupingTVController: UITableViewController {
    
    let realm = try! Realm()
    
    var groupingArray: Results<Grouping>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return groupingArray?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = groupingArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    func preepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = groupingArray?[indexPath.row]
        }
    }
    
    //MARK: - Model Manipulation Methods
    
    func save(groupingArray: Grouping) {
        
        do {
            try realm.write {
                realm.add(groupingArray)
            }
        } catch {
            print("Error saving categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        groupingArray = realm.objects(Grouping.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Categories", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Grouping()
            
            newCategory.name = textField.text!
            
            self.save(groupingArray : newCategory)
        }

        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Create new category"
        }
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}
