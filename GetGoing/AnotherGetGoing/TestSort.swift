//
//  TestSort.swift
//  AnotherGetGoing
//
//  Created by Lourdes Roashan on 29/06/18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import Foundation


class Items {
    var name: String
    var rating: Int

    init(name: String, rating: Int){
        self.name = name
        self.rating = rating
    }


}

let apple = Items(name:"Apple",rating:4)
let banana = Items(name:"Banana",rating:3)
let orange = Items(name:"Orange",rating:5)

var items: [Items] = [apple, banana, orange]
