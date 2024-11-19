//
//  EditNotesViewController.swift
//  Note
//
//  Created by Habibur Rahman on 11/18/24.
//

import UIKit

class EditNoteViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    var titleName: String?
    var detail: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        detailTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tap(sender:))
        )
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
        if let titleName, let detail {
            titleTextField.text = titleName
            detailTextField.text = detail
        }
    }

    @objc func tap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Update Note", message: "Are you sure you want to update this note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: TextField                                        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
