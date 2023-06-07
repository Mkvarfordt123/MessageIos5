//
//  MessagesTableViewController.swift
//  MessagesIOS5
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func addMessageButtonTapped(_ sender: Any) {
        presentNewMessageAlert()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        
        let message = MessageController.shared.messages[indexPath.row]
        cell.updateUI(message: message)
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let message = MessageController.shared.messages[indexPath.row]
            MessageController.shared.deleteMessage(message: message)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    // MARK: - Functions
    
    func presentNewMessageAlert() { let alert = UIAlertController(title: "New Message", message: "Type your message below", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Your message here..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Post", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                  let messageText = textField.text else { return }
            MessageController.shared.createMessage(text: messageText)
            self.tableView.reloadData()
        }
        
        alert.addAction(dismissAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Thursday, the best day of the year
        }
}
// MARK: - Extensions
extension MessagesTableViewController: MessageTableViewCellDelegate {
    func messageButtonTapped(cell: MessageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let message = MessageController.shared.messages[indexPath.row]
        MessageController.shared.toggleIsRed(message: message)
        cell.updateUI(message: message)
    }
}
