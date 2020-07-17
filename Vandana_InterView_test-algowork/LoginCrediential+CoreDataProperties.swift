//
//  LoginCrediential+CoreDataProperties.swift
//  Vandana_InterView_test-algowork
//
//  Created by Vandana Mishra on 7/16/20.
//  Copyright © 2020 Vandana Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension LoginCrediential {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginCrediential> {
        return NSFetchRequest<LoginCrediential>(entityName: "LoginCrediential")
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}
