//
//  Debugging.swift
//  Contacts
//
//  Created by Dave Kondris on 07/09/21.
//

import Foundation

func findPath () {
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print(paths[0])
}
