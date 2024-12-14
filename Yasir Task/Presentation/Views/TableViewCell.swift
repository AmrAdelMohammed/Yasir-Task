//
//  TableViewCell.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import UIKit
import SwiftUI

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    private var hostingController: UIHostingController<SwiftUICellContent>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        let swiftUIView = SwiftUICellContent(text: text)
        if hostingController == nil {
            hostingController = UIHostingController(rootView: swiftUIView)
            if let hostView = hostingController?.view {
                hostView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(hostView)
                NSLayoutConstraint.activate([
                    hostView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    hostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    hostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    hostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
            }
        } else {
            hostingController?.rootView = swiftUIView
        }
    }
}

// MARK: - SwiftUI Content for TableView Cells
struct SwiftUICellContent: View {
    let text: String

    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.2))
    }
}

