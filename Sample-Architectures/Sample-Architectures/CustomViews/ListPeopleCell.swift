//
//  ListPeopleCell.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

class ListPeopleCell: UITableViewCell {
    
    var person:Person? {
        didSet {
            if let person = person {
                self.textLabel!.text = person.nameAndAge
            }
        }
    }
    
}
