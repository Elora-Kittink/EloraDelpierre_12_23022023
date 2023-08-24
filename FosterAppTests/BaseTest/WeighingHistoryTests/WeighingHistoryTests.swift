//
//  WeighingHistoryTests.swift
//  FosterAppTests
//
//  Created by Elora on 18/08/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class WeighingHistoryTests: XCTestCase {
	let worker = DBWorker()
	let user = User(mail: "UT", id: "UT", name: "UT")
	let litter = Litter(isOngoing: true, rescueDate: "UT")
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
	let kitten = Kitten(id: "test", litter: litter, firstName: "test", secondName: "test", birthdate: self.date, sex: "test", color: "test", rescueDate: self.date, siblings: nil, comment: nil, isAdopted: false, microship: nil, vaccines: nil, adopters: nil, weighingHistory: [], isAlive: true)
}
