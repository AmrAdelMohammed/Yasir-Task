//
//  DetailsView.swift
//  Yasir Task
//
//  Created by Amr Adel on 22/12/2024.
//

import SwiftUI

struct DetailsView: View {
    
    var character: CharacterEntity?
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: character?.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()  // Show a loading spinner
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(7)
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .background(Color.gray.opacity(0.3))
                @unknown default:
                    EmptyView()
                }
            }
            HStack {
                Text(character?.name ?? "Unknown")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                Spacer()
                
                Text(character?.status?.rawValue ?? "status")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(Color.cyan)
                    .clipShape(Capsule())
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 16)
            
            HStack {
                Text(character?.species ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text(".").padding(3)
                
                Text(character?.gender?.rawValue ?? "gender")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            
            HStack{
                Text("Location : \(character?.location ?? "")")
                    .foregroundStyle(
                                        LinearGradient(gradient: Gradient(colors: [.black, .gray]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                Spacer()
            }.padding([.leading, .trailing], 16)
            Spacer()
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(leading: backButton) // Add custom back button
        .edgesIgnoringSafeArea(.top)
    }
    private var backButton: some View {
        Button(action: {
            // Action to pop the view controller (handled by UIKit)
            if let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                navController.popViewController(animated: true)
            }
        }) {
            Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
        }
    }
}

#Preview {
    DetailsView(character: nil)
}
