//
//  MessageController.swift
//  MessagesIOS5
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import Foundation

class MessageController {
    // MARK: - Properties
    static let shared = MessageController()
    private(set) var messages: [Message] = []
    
    // MARK: - Functions
    func createMessage(text: String) {
        let message = Message(text: text)
        messages.append(message)
        save()    }
    func deleteMessage(message: Message) {
        guard let index = messages.firstIndex(of: message) else { return }
        messages.remove(at: index)
        save()    }
    
    func toggleIsRed(message: Message) {
        message.isRead.toggle()
        save()
    }
    
    // MARK: - Persistence
    func save() {
        guard let url = fileURL else { return }
        do {
            //this is for the single source of truth
            let data = try JSONEncoder().encode(messages)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let messages = try JSONDecoder().decode([Message].self, from: data)
            self.messages = messages
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("messages.json")
        return url
    }
}
