//
//  SandBoxB.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SandBoxB {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .screenButtonTapped:
                return .none
            case .view(.viewDidAppear):
                state.data = IdentifiedArrayOf(uniqueElements: [
                     ElementData(title: "Title 1", color: .red),
                     ElementData(title: "Title 2", color: .green),
                     ElementData(title: "Title 3", color: .blue),
                     ElementData(title: "Title 4", color: .yellow),
                     ElementData(title: "Title 5", color: .orange)
                 ])
                return .none
                
            //default: return .none
            }
        }
    }
}

extension SandBoxB {
    
    @CasePathable
    enum Action: ViewAction {
        case screenButtonTapped
        
        case view(View)
        
        enum View {
            
            case viewDidAppear
        }
    }
    
}

extension SandBoxB {
    
    @ObservableState
    struct State: Equatable {
        var data: IdentifiedArrayOf<ElementData> = []
    }
    
}

struct SandBoxBView: View {
    
    let store: StoreOf<SandBoxB>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(store.data) { item in
                        container(title: item.title, color: item.color) 
                    }
                }
                .navigationTitle("SandBox screen B")
            }
            .onAppear {
                store.send(.view(.viewDidAppear))
            }
        }
    }
    
    private func container(title: String, color: Color) -> some View {
        GroupBox {
            VStack {
                Spacer().frame(height: 100)
                Button {
                    print("Container button tapped")
                } label: {
                    Text(title)
                }
                Spacer().frame(height: 100)
            }
            .frame(maxWidth: .infinity)
        }
        .groupBoxStyle(ContainerBoxStyle(color: color))
    }
    
    private var columns: [GridItem] {
        [ GridItem(.flexible()) ]
    }
    
}

struct ElementData: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}

//                ForEach(1...5, id: \.self) { index in
//                    container(title: "Title index: \(index)",
//                              index: index)
//                }

//var elements: [ElementData] = [
//     ElementData(title: "Title 1", color: .red),
//     ElementData(title: "Title 2", color: .green),
//     ElementData(title: "Title 3", color: .blue),
//     ElementData(title: "Title 4", color: .yellow),
//     ElementData(title: "Title 5", color: .orange)
// ]

struct ContainerBoxStyle: GroupBoxStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .frame(height: 50)
            configuration.content
        }
        .padding()
        .background(color)
        .cornerRadius(8)
    }
    
}
