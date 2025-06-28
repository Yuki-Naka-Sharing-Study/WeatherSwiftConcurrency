//
//  Weather.swift
//  WeatherSwiftConcurrency
//
//  Created by 仲優樹 on 2025/06/28.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let city: String
    let temperature: Int
    let description: String
}
