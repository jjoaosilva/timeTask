//
//  FileTasks.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 22/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

func createMealNewFile(data: [Task]) {
    if let data = try? JSONEncoder().encode(data) {
        FileController().createFile(with: data, name: "TaskData.Json")
    }
}

func readMealDataFromFile() -> [Task]? {

    if let data = FileController().retrieveFile(at: "TaskData.Json") {
        let allmeals = try? JSONDecoder().decode([Task].self, from: data)
        return allmeals
    }
    return nil
}

func updateMealDataFile(data: [Task]) -> Data? {

    if let data = try? JSONEncoder().encode(data) {
        FileController().updateFile(at: "TaskData.Json", data: data)
        return data
    }
    return nil
}
