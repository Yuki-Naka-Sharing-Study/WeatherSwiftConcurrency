//
//  WeatherViewModel.swift
//  WeatherSwiftConcurrency
//
//  Created by 仲優樹 on 2025/06/28.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weathers: [Weather] = []
    
    func fetchWeathersWithAsyncLet() {
        Task {
            async let tokyo = fetchWeather(for: "東京")
            async let osaka = fetchWeather(for: "大阪")
            async let fukuoka = fetchWeather(for: "福岡")
            
            let results = await [tokyo, osaka, fukuoka]
            self.weathers = results
        }
    }
    
    func fetchWeathersWithTaskGroup() {
        let cities = ["札幌", "仙台", "名古屋", "広島", "那覇"]
        Task {
            var results: [Weather] = []
            
            await withTaskGroup(of: Weather?.self) { group in
                for city in cities {
                    group.addTask {
                        await self.fetchWeather(for: city)
                    }
                }
                
                for await result in group {
                    if let weather = result {
                        results.append(weather)
                    }
                }
            }
            self.weathers = results
        }
    }
    
    // ダミーAPI: 擬似的にランダム天気を非同期取得
    func fetchWeather(for city: String) async -> Weather {
        try? await Task.sleep(nanoseconds: UInt64(Int.random(in: 500...1000)) * 1_000_000)
        return Weather(
            city: city,
            temperature: Int.random(in: 10...35),
            description: ["晴れ", "曇り", "雨"].randomElement()!
        )
    }
}
