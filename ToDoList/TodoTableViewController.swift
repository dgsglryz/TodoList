//
//  TodoTableViewController.swift
//  ToDoList
//
//  Created by Helin Akın on 11.05.2023.
//

import UIKit

class TodoTableViewController: UITableViewController {
  
  var toDos = [ToDo]()
  
  @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveUnwind" else { return }
    let sourceViewController = segue.source as!
    ToDoDetailTableViewController
     
    if let toDo = sourceViewController.toDo {
      if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
        toDos[indexOfExistingToDo] = toDo
        tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo,
                                            section: 0)], with: .automatic)
      } else {
        let newIndexPath = IndexPath(row: toDos.count, section: 0)
        toDos.append(toDo)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let savedToDos = ToDo.loadToDos() {
      toDos = savedToDos
    } else {
      toDos = ToDo.loadSampleToDos()
    }
    navigationItem.leftBarButtonItem = editButtonItem
    
  }
  
  // MARK: - Table view data source
  
  @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) ->
  ToDoDetailTableViewController? {
    let detailController = ToDoDetailTableViewController(coder: coder)
     
    guard let cell = sender as? UITableViewCell,​        let indexPath = tableView.indexPath(for: cell) else {
      // if sender is the add button, return an empty controller
      return detailController
    }
     
    tableView.deselectRow(at: indexPath, animated: true)
     
    detailController?.toDo = toDos[indexPath.row]
     
    return detailController
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return toDos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt
                          indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath)
    let toDo = toDos[indexPath.row]
    var content = cell.defaultContentConfiguration()
    content.text = toDo.title
    cell.contentConfiguration = content
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt
                          indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit
                          editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
                          IndexPath) {
    if editingStyle == .delete {
      toDos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
