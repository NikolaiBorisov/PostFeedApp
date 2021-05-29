//
//  DateValueWrapper.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import Foundation

@propertyWrapper
struct DateValue: Decodable {
  
  var wrappedValue: String {
    let date = Date(timeIntervalSince1970: value / Constants.TimeConstants.millisecondsInOneSecond)
    return yearAndMonthAndDateFormatter.string(from: date)
  }
  
  private let value: TimeInterval
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.value = try container.decode(TimeInterval.self)
  }
  
  private var yearAndMonthAndDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.TimeAndDateFormat.myDateFormatStyle
    formatter.locale = Locale(identifier: Constants.TimeAndDateFormat.localeIdentifier)
    return formatter
  }
  
}
