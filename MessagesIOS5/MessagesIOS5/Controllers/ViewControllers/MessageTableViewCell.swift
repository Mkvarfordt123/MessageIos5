//
//  MessageTableViewCell.swift
//  MessagesIOS5
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import UIKit

protocol MessageTableViewCellDelegate: AnyObject {
    func messageButtonTapped(cell: MessageTableViewCell)
}

class MessageTableViewCell: UITableViewCell {
// MARK: - Outlets
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageSubtitleLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: MessageTableViewCellDelegate?
    
    // MARK: - Functions
    
    func updateUI(message: Message) {
        messageTextLabel.text = message.text
        messageSubtitleLabel.text = DateFormatter.short().string(from: message.timeStamp)
        let image = UIImage(systemName: message.isRead ? "moon.stars.fill" : "moon.stars")
        messageButton.setImage(image, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func messageButtonTapped(_ sender: Any) {
        delegate?.messageButtonTapped(cell: self)
    }
}
