//
//  HomeViewController.swift
//  Note
//
//  Created by Habibur Rahman on 11/15/24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes: [Notes]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView()
        settingNavigation()
    }
    
    // MARK: Navigation
    private func settingNavigation() {
        let title = "Notes"
        navigationItem.title = title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(
                navigateToAddNote
            )
        )
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector (editButtonItemTapped)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllNotes()
    }
    
    @objc func editButtonItemTapped() {
        tableView.isEditing.toggle()
    }
    
    @objc func navigateToAddNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNoteVC") as? AddNoteViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: TableView
    
    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        noteCell.textLabel?.text = "\(notes?[indexPath.row].title ?? "")"
        noteCell.detailTextLabel?.text = "\(notes?[indexPath.row].detail ?? "")"
        return noteCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes?[indexPath.row]
            context.delete(noteToDelete!)
            do {
                try context.save()
                DispatchQueue.main.async {
                    self.getAllNotes()
                }
            } catch {
            }
        } else if editingStyle == .insert {

        }
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        notes?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func getAllNotes() {
        do {
            notes = try context.fetch(Notes.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EditNoteVC") as? EditNoteViewController {
            vc.titleName = notes?[indexPath.row].title
            vc.detail = notes?[indexPath.row].detail
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
