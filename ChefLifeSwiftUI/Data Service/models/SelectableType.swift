//
//  SelectableType.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

protocol SelectableType: Identifiable {
  var name: String { get }
}

struct SelectableHolder: SelectableType, Identifiable {
  var id: UUID
  var name: String
  init<U>(selectable name: U) where U: SelectableType {
    self.name = name.name
    self.id = UUID()
  }
}
