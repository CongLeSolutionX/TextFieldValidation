//
//  CustomTableViewCell.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/7/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var congTextField = CongUITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(congTextField)
        congTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            congTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            congTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            congTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            congTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
