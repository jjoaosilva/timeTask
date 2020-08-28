//
//  HIstoricTask.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 26/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

struct HistoricTasks: Codable {
    var date: String // Feedback:Verificar o uso do tipo date
    var tasks: [Task]
}

// Feedback:Pensar sobre o feedback da gabi, sobre por a data de criação na propria Task e verificar.
// Feedback:verificar locale
// Feedback:verificar o uso de extensions de date -- posso pesquisar solucoes ja feitas e ver melhor forma possivel
