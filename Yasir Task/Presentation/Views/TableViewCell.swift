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
    
    func configure(with character: CharacterEntity?) {
        let swiftUIView = SwiftUICellContent(character: character)
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
    let character: CharacterEntity?
    private var backgroundColor: Color {
        switch character?.gender {
        case .male:
            return Color.blue.opacity(0.1)
        case .female:
            return Color.pink.opacity(0.1)
        default:
            return Color.white
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                AsyncImage(url: URL(string: character?.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()  // Show a loading spinner
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(7)
                            
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                    @unknown default:
                        EmptyView()
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text(character?.name ?? "Unknown Name")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(character?.species ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading)
                Spacer()
            }
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
