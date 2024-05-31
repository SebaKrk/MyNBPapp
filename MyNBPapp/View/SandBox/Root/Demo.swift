//
//  Demo.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

/// This wrapper provides an "entry" point into an individual demo that can own a store.
struct Demo<State, Action, Content: View>: View {
  @SwiftUI.State var store: Store<State, Action>
  let content: (Store<State, Action>) -> Content

  init(
    store: Store<State, Action>,
    @ViewBuilder content: @escaping (Store<State, Action>) -> Content
  ) {
    self.store = store
    self.content = content
  }

  var body: some View {
    self.content(self.store)
  }
}
