//
//  ViewController.swift
//  RealmTest-swift-
//
//  Created by 武卓 on 2017/8/8.
//  Copyright © 2017年 武卓. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var lists : Results<TaskList>!
    var isEditingMode: Bool = false
    var currentCreateAction :UIAlertAction!
    var listTableView :UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstConfig()
        createTable()
        initSegmented()
    }
    
    func firstConfig() {
        title = "TaskList"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftItemAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(rightItemAction))
    }

    func loadTask() {
        lists = TCZRealm.objects(TaskList.self)
        listTableView.setEditing(false, animated: true)
        listTableView.reloadData()
    }
    
    func leftItemAction() {
        isEditingMode = !isEditingMode
        listTableView.setEditing(isEditingMode, animated: true)
    }
    
    func rightItemAction() {
        alertAddTask(nil)
    }
    
    func didSelectSortCriteria(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            //A - z
            self.lists = self.lists.sorted(byKeyPath: "name")
        } else
        {
            // data
            self.lists = self.lists.sorted(byKeyPath: "createdAt", ascending: true)
        }
        listTableView.reloadData()
    }
    
    //Enable the create action of the alert only if textfield text is not empty
    func listNameFieldDidChange(_ textField:UITextField){
        currentCreateAction.isEnabled = (textField.text?.characters.count)! > 0
    }
    
    func alertAddTask(_ updateList: TaskList!) {
        var title = "New Tasks List"
        var doneTitle = "Done Task"
        if updateList != nil {
            title = "UpData Tasks List"
            doneTitle = "UpData"
        }
        let alertController = UIAlertController.init(title: title, message: "Write the name of your tasks list.", preferredStyle: UIAlertControllerStyle.alert)
        let createAction = UIAlertAction.init(title: doneTitle, style: UIAlertActionStyle.default) { (UIAlertAction) in
            let listName = alertController.textFields?.first?.text
            
            if updateList != nil {
                try! TCZRealm.write {
                    updateList.name = listName!
                    self.loadTask()
                }
            }else {
                let newTaskList = TaskList()
                newTaskList.name = listName!
                try! TCZRealm.write {
                    TCZRealm.add(newTaskList)
                    self.loadTask()
                }
            }
            print(listName ?? "")
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        currentCreateAction = createAction
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alertController.addTextField { (textField) in
            textField.placeholder = "Tesk List Name"
            textField.addTarget(self, action: #selector(self.listNameFieldDidChange(_:)), for: UIControlEvents.editingChanged)
            if updateList != nil {
                textField.text = updateList.name
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = lists {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")
        let list = lists[indexPath.row]
        
        cell?.textLabel?.text = list.name
        cell?.detailTextLabel?.text = "\(list.taskList.count) task"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delAction = UITableViewRowAction(style: .default, title: "Del") { (delAction, indexPath) in
            
            let delList = self.lists[indexPath.row]
            try! TCZRealm.write {
                TCZRealm.delete(delList)
                self.loadTask()
            }
        }
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (editAction, indexPath) in
            
            let edList = self.lists[indexPath.row]
            self.alertAddTask(edList)
        }
        
        return [delAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func createTable() {
        
        listTableView = UITableView.init(frame:CGRect(x: 0, y: 40, width: view.bounds.width, height: view.bounds.height), style: UITableViewStyle.plain)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        self.view.addSubview(listTableView)
    }
    
    private func initSegmented() {
        let items = ["A-Z","Data"]
        
        let segment = UISegmentedControl.init(items: items)
        segment.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 40)
        segment.center.x = self.view.center.x
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(didSelectSortCriteria(_:)), for: UIControlEvents.allEvents)
        self.view.addSubview(segment)
    }

}

