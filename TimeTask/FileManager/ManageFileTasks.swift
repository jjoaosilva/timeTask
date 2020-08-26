//
//  FileTasks.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 22/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

struct ManageFileTasks {
    static func createTasksNewFile(data: [HistoricTasks]) {
        if let data = try? JSONEncoder().encode(data) {
            FileController().createFile(with: data, name: "TaskData.Json")
        }
    }

    static func createMockTasks(date: String) -> Data? {

        let historic01 = HistoricTasks(date: date, tasks: [
            Task(activity: "teste1", description: "teste1", check: false),
            Task(activity: "teste2", description: "teste2", check: false),
            Task(activity: "teste3", description: "teste3", check: false)
        ])

        let historic02 = HistoricTasks(date: "22-08-2020", tasks: [
            Task(activity: "teste1 22-08-2020", description: "teste1", check: true),
            Task(activity: "teste2 22-08-2020", description: "teste2", check: false)
        ])

        let historic03 = HistoricTasks(date: "20-08-2020", tasks: [
            Task(activity: "teste1 20-08-2020", description: "teste1", check: true)
        ])

        let historic04 = HistoricTasks(date: "15-08-2020", tasks: [
            Task(activity: "teste1 15-08-2020", description: "teste1", check: true),
            Task(activity: "teste2 15-08-2020", description: "teste2", check: true),
            Task(activity: "teste3 15-08-2020", description: "teste3", check: true),
            Task(activity: "teste4 15-08-2020", description: "teste4", check: true),
            Task(activity: "teste5 15-08-2020", description: "teste5", check: false),
            Task(activity: "teste6 15-08-2020", description: "teste6", check: true)
        ])

        let mockTasks = [historic01, historic02, historic03, historic04]

        if let data = try? JSONEncoder().encode(mockTasks) {
            FileController().updateFile(at: "TaskData.Json", data: data)
            return data
        }
        return nil
    }

    static func readTasksDataFromFile() -> [HistoricTasks]? {

        if let data = FileController().retrieveFile(at: "TaskData.Json") {
            let allTasks = try? JSONDecoder().decode([HistoricTasks].self, from: data)
            return allTasks
        }
        return nil
    }

    static func readTodayTasksFromFile() -> [Task]? {

        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)

        if let data = FileController().retrieveFile(at: "TaskData.Json") {
            let allTasks = try? JSONDecoder().decode([HistoricTasks].self, from: data)

            let todayTasks = allTasks?.filter { $0.date == formattedDate}

            if let tasks = todayTasks, !tasks.isEmpty {
                return tasks.first?.tasks
            }
        }
        return nil
    }

    static func updateTasksDataFile(data: [Task], date: String) -> Data? {

        var allTasks = readTasksDataFromFile()

        if let tasks = allTasks {
            if let index = tasks.firstIndex(where: { $0.date == date}) {
                allTasks?[index].tasks = data
            } else {
                allTasks?.append(HistoricTasks(date: date, tasks: data))
            }
        } else {
            allTasks = [HistoricTasks(date: date, tasks: data)]
        }

        if let data = try? JSONEncoder().encode(allTasks) {
            FileController().updateFile(at: "TaskData.Json", data: data)
            return data
        }
        return nil
    }
}
