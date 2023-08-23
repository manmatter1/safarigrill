//
//  MenuItemViewModel.swift
//  Safari Grill
//
//  Created by Jay Jayaprakash on 23/08/2023.
//

import SwiftUI
import FirebaseFirestore


class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    init(urlString: String) {
        load(urlString: urlString)
    }
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
            }
        }.resume()
    }
}



class MenuItemViewModel:ObservableObject{
    @Published var MenuItems = [MenuItem]()
    
    func getData() {
        // Get Reference
        let db = Firestore.firestore()
        
        // Fetch data for the specified date
        db.collection("menuItems").getDocuments { snapshot, error in
            // No error
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        self.MenuItems = snapshot.documents.compactMap { d in
                            print("Document Data: \(d.data())") // Print the whole document data

                            let name = d["name"] as? String ?? ""
                            print("Name from Document: \(name)") // Print the name

                            // Mapping
                            return MenuItem(
                                id: d.documentID,
                                name: name,
                                category: d["category"] as? String ?? "",
                                description: d["description"] as? String ?? "",
                                price: d["price"] as? Double ?? 0.00,
                                imageURL: d["imageURL"] as? String ?? ""
                            )
                        }
                        print("Mapped Menu Items: \(self.MenuItems)") // Print the final array of menu items

                        
                    }
                }
            }
            // Error is true
            else {
                // Handle Error
            }
        }
        
        
    }
    
}
