//
//  CardListView.swift
//  StudyCards
//
//  Created by Djuro on 4/1/21.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject var cardListViewModel: CardListViewModel
    @State private var showingForm = false
    @State private var showPassed = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showPassed) {
                    Text("\(showPassed ? "Hide" : "Show") passed questions")
                }
                List {
                    ForEach(cardListViewModel.cardViewModels.filter { $0.studyCard.passed == showPassed }) { cardVM in
                        CardView(cardViewModel: cardVM)
                            .onLongPressGesture(minimumDuration: 1.5) {
                                var studyCard = cardVM.studyCard
                                studyCard.passed.toggle()
                                cardListViewModel.update(studyCard)
                            }
                    }.onDelete(perform: delete)
                }
                .listStyle(InsetListStyle())
                .navigationTitle("Study Cards")
                    
                Button(action: {
                    showingForm = true
                }) {
                    Circle()
                        .fill(Color.green)
                        .frame(height: 60)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                }.sheet(isPresented: $showingForm) {
                    FormView { (studyCard) in
                        cardListViewModel.add(studyCard)
                        showingForm = false
                    }
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.map { cardListViewModel.cardViewModels[$0].studyCard }.forEach(cardListViewModel.remove)
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardListViewModel: CardListViewModel())
    }
}
