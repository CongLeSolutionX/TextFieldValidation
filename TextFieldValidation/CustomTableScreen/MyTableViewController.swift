//
//  MyTableViewController.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import SwiftUI

class MyTableViewController: UITableViewController {
    var viewModel = TextViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        // It is important to set an estimated row height for cells that contain dynamic content
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        // Register a UITableViewCell and CongBaseTableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    // UITableViewDataSource function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    // UITableViewDataSource function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = .green
        
        if indexPath.row == 0 { // Assign UITextView to an UITableViewCell for the first row
            // Add a UITextView if it doesn't exist
            if cell.viewWithTag(100) == nil {
                let textView = UITextView()
                textView.translatesAutoresizingMaskIntoConstraints = false // Use Auto Layout
                
                textView.tag = 100
                textView.delegate = self
                textView.backgroundColor = .yellow
                
                cell.contentView.addSubview(textView)
                cell.backgroundColor = .green
                
                NSLayoutConstraint.activate([
                    textView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                    textView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                    textView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                    textView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
                ])
                
                // To allow the user to interact with the textField, you need to make sure that cell selection doesn't interfere
                cell.selectionStyle = .none
            }
        } else if indexPath.row == 1 { // Assign customized text field to an UITableViewCell for the second rows
            let congTextField = CongUITextField()
            congTextField.backgroundColor = .blue
            congTextField.translatesAutoresizingMaskIntoConstraints = false
            congTextField.placeholder = "Cong Text Field View"
            
            cell.contentView.addSubview(congTextField)
            cell.contentView.backgroundColor = .brown
            
            NSLayoutConstraint.activate([
                congTextField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                congTextField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                congTextField.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                congTextField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
//                congTextField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
//                congTextField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
//                congTextField.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
//                congTextField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            ])
        }
        return cell
    }
}

// MARK: - TextViewViewModel
class TextViewViewModel {
    func shouldChangeCharacters(in range: NSRange, replacementText text: String) -> Bool {
        // Validation logic
        if text.count > 0 {
            return true
        }
        return false
    }
}

// MARK: - UITextViewDelegate
extension MyTableViewController: UITextViewDelegate {
  
}

// MARK: - Preview without navigation bar items from UIKit UIViewController
@available(iOS 13, *)
struct BaseUITableView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyTableViewController {
        /// Protocol `UIViewControllerRepresentable` only allows us to load `UIKit view` of `UIViewController`,
        /// but not the navigation bar items from the `UINavigationController`
        MyTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyTableViewController, context: Context) {}
}

@available(iOS 13, *)
struct PreviewBaseUITableView: PreviewProvider {
    static var previews: some View {
        BaseUITableView()
    }
}

