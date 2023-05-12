//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Helin Akın on 12.05.2023.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
  var isDatePickerHidden = true
  let dateLabelIndexPath = IndexPath(row: 0, section: 1)
  let datePickerIndexPath = IndexPath(row: 1, section: 1)
  let notesIndexPath = IndexPath(row: 0, section: 2)
  var toDo: ToDo?
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
  @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    let title = titleTextField.text ?? ""
    let isComplete = isCompleteButton.isSelected
    let dueDate = dueDateDatePicker.date
    let notes = notesTextView.text ?? ""
    
    toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    
  }
  @IBOutlet var saveButton: UIBarButtonItem!
  @IBOutlet var notesTextView: UITextView!
  @IBOutlet var dueDateDatePicker: UIDatePicker!
  @IBOutlet var dueDateLabel: UILabel!
  @IBOutlet var titleTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    let currentDueDate: Date
    if let toDo = toDo {
      navigationItem.title = "To-Do"
      titleTextField.text = toDo.title
      isCompleteButton.isSelected = toDo.isComplete
      currentDueDate = toDo.dueDate
      notesTextView.text = toDo.notes
    } else {
      currentDueDate = Date().addingTimeInterval(24*60*60)
    }
    
    dueDateDatePicker.date = Date().addingTimeInterval(24*60*60)
    updateDueDateLabel(date: dueDateDatePicker.date)
    updateSaveButtonState()
    
    let date = dueDateDatePicker.date
    dueDateLabel.text = date.formatted(.dateTime
      .month(.defaultDigits)
      .day()
      .year(.twoDigits)
      .hour()
      .minute())
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard segue.identifier == "saveUnwind" else { return }
    let title = titleTextField.text!
    let isComplete = isCompleteButton.isSelected
    let dueDate = dueDateDatePicker.date
    let notes = notesTextView.text
    if toDo != nil {
      toDo?.title = title
      toDo?.isComplete = isComplete
      toDo?.dueDate = dueDate
      toDo?.notes = notes
    } else {
      toDo = ToDo(title: title, isComplete: isComplete,
                  dueDate: dueDate, notes: notes)
    }
  } 
  
  func updateDueDateLabel(date: Date) {
    dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits)
      .day().year(.twoDigits).hour().minute())
  }
  
  @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    updateDueDateLabel(date: sender.date)
    
  }
  func updateSaveButtonState() {
    let shouldEnableSaveButton = titleTextField.text?.isEmpty ==
    false
    saveButton.isEnabled = shouldEnableSaveButton
  }
  @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
    let date = sender.date
    dueDateLabel.text = date.formatted(.dateTime
      .month(.defaultDigits)
      .day()
      .year(.twoDigits)
      .hour()
      .minute())
  }
  
  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case datePickerIndexPath where isDatePickerHidden == true:
      return 0
    case notesIndexPath:
      return 200
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case datePickerIndexPath:
      return 216
    case notesIndexPath:
      return 200
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath == dateLabelIndexPath {
      isDatePickerHidden.toggle()
      updateDueDateLabel(date: dueDateDatePicker.date)
      tableView.beginUpdates()
      tableView.endUpdates()
    }
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
