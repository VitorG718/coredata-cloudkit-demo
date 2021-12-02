//
//  ViewController.swift
//  CoreDataAndCloudKitDemo
//
//  Created by Vitor Gledison Oliveira de Souza on 02/12/21.
//

import UIKit

class ViewController: UIViewController {

    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .clear
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 15.0
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 2.0
        return field
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Adicionar"
        button.configuration?.baseBackgroundColor = .purple
        button.configuration?.baseForegroundColor = .white
        return button
    }()

    private var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTasks()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.1)),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width * 0.1),
            button.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            button.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            button.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: view.frame.width * 0.1)
        ])
    }

    @objc private func buttonAction() {
        if let text = nameTextField.text, !text.isEmpty {
            let task = Task(context: PersistenceController.shared.coreDataContext)
            task.name = text
            PersistenceController.shared.saveContext()
            nameTextField.text = ""
            fetchTasks()
        }
    }
    
    private func fetchTasks() {
        do {
            tasks = try PersistenceController.shared.coreDataContext.fetch(Task.fetchRequest())
            tasks.forEach{ task in
                if let name = task.name {
                    print("Task: \(name)")
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

