//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Helin Akın on 12.05.2023.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
  @IBOutlet var isCompleteButton: UIButton!
  
  @IBAction func toggleIsComplete(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    
  }
  @IBAction func returnPressed(_ sender: UITextField) {
    sender.resignFirstResponder()
    
  }
  @IBAction func textEditingChanged(_ sender: UITextField) {
    updateSaveButtonState()
    
  }
  @IBOutlet var saveButton: UIBarButtonItem!
  @IBOutlet var notesTextView: UITextView!
  @IBOutlet var dueDateDatePicker: UIDatePicker!
  @IBOutlet var dueDateLabel: UILabel!
  @IBOutlet var titleTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    updateSaveButtonState()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  func updateSaveButtonState() {
    let shouldEnableSaveButton = titleTextField.text?.isEmpty ==
    false
    saveButton.isEnabled = shouldEnableSaveButton
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
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
