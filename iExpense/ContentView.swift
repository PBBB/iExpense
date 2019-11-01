//
//  ContentView.swift
//  iExpense
//
//  Created by Issac Penn on 2019/10/31.
//  Copyright © 2019 Issac Penn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                        .foregroundColor(
                        {
                            if item.amount < 10{
                                return Color.black
                            } else if item.amount < 100 {
                                return Color.blue
                            } else {
                                return Color.red
                            }
                            
                        }()
                        )
                    }
                }
                .onDelete(perform: removeItems(at:))
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                    self.showingAddExpense = true
                                }, label: {
                                    Image(systemName: "plus")
                                }))
//            .navigationBarItems(leading: EditButton())
        }
        .sheet(isPresented: $showingAddExpense, content: { AddView(expenses: self.expenses) })
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let a = ContentView()
        a.expenses.items = [ExpenseItem(name: "name", type: "type", amount: 100)]
        return a
    }
}
