//
//  MyTableViewController.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import SwiftUI

class MyTableViewController: UITableViewController {
    
    var viewModel: TextViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        viewModel = TextViewViewModel() // Initialize the viewModel
        
        // Register a UITableViewCell and CongBaseTableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "CongBaseTableViewCell")
    }
    
    // UITableViewDataSource function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // UITableViewDataSource function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { // Use UITableViewCell for the first row
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.backgroundColor = .green
            
            // Add a UITextView if it doesn't exist
            if cell.viewWithTag(100) == nil {
                let textView = UITextView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: cell.contentView.frame.width,
                        height: cell.contentView.frame.height
                    )
                )
                textView.tag = 100
                textView.delegate = self
                textView.backgroundColor = .yellow
                
                cell.contentView.addSubview(textView)
            }
            return cell
        } else { // Use CongBaseTableViewCell for the second row
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CongBaseTableViewCell", for: indexPath)
            return cell
        }
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
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return viewModel?.shouldChangeCharacters(in: range, replacementText: text) ?? true
    }
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

