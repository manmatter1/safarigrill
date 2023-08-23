//
//  MenuItemModel.swift
//  Safari Grill
//
//  Created by Jay Jayaprakash on 23/08/2023.
//

import Foundation

struct MenuItem:Identifiable{
    var id:String
    var name:String
    var category:String
    var description:String
    var price:Double
    var imageURL:String
}
