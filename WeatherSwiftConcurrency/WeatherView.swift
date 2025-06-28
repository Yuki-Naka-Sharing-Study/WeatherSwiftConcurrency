//
//  WeatherView.swift
//  WeatherSwiftConcurrency
//
//  Created by 仲優樹 on 2025/06/28.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Button("東京/大阪/福岡") {
                        viewModel.fetchWeathersWithAsyncLet()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("全国5都市") {
                        viewModel.fetchWeathersWithTaskGroup()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                List(viewModel.weathers) { weather in
                    VStack(alignment: .leading) {
                        Text("\(weather.city)")
                            .font(.headline)
                        Text("気温: \(weather.temperature)℃")
                        Text("天気: \(weather.description)")
                    }
                }
            }
            .padding()
            .navigationTitle("天気取得デモ")
        }
    }
}

#Preview {
    WeatherView()
}
