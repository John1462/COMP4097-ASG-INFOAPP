//
//  HomeEvent.swift
//  InfoApp
//
//  Created by John Yang on 15/10/2019.
//  Copyright © 2019 MTCHOY. All rights reserved.
//

import Foundation
import RealmSwift

class HomeEvent: Object {
    let id = RealmOptional<Int>()
    @objc dynamic var event_id: String? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var organizer: String? = nil
    @objc dynamic var quota: String? = nil
    @objc dynamic var shortDescription: String? = nil
    @objc dynamic var fullDescription: String? = nil
    @objc dynamic var imgURL: String? = nil
    @objc dynamic var date: String? = nil
    @objc dynamic var time: String? = nil
    @objc dynamic var venue: String? = nil

}
