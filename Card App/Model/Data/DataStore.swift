    //
    //  Manager.swift
    //  Card App
    //
    //  Created by Sasha on 30.12.24.
    //

import Foundation


class DataStore {


    static let shared = DataStore()


    let photos: [String] = [
        "bannana", 
        "chill",
        "freedom",
        "lemon",
        "pink",
        "road",
        "sand",
        "sleepOnTable",
        "womenAndTree"
    ]


    private init() {}

}
