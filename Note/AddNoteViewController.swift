//
//  ViewController.swift
//  Note
//
//  Created by Habibur Rahman on 11/15/24.
//

import UIKit


class AddNoteViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    @objc func tap(sender: UITapGestureRecognizer) {
       self.view.endEditing(true)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func addNoteButtonTapped(_ sender: Any) {
        guard let titleText = titleTextField.text, !titleText.isEmpty else {
            titleTextField.placeholder = "Please enter title"
            titleTextField.becomeFirstResponder()
            return
        }
        
        guard let detailText = detailTextField.text, !detailText.isEmpty else {
            detailTextField.placeholder = "Please enter detail"
            detailTextField.becomeFirstResponder()
            return
        }
        
        let note = Notes(context: context)
        note.title = titleText
        note.detail = detailText
        
        do {
            try context.save()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

}

