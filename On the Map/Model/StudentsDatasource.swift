//
//  StudentsDatasource.swift
//  On the Map
//
//  Created by Malik Basalamah on 06/04/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation

class StudentDataSource{
    
    var studentLocations = [StudentInformation]()

    // MARK: Singleton
    // Make a shared instance of StudentDataSource class
    
    static let sharedInstance = StudentDataSource()
    private init() {}
}

