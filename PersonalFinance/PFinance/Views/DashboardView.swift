//
//  ContentView.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI
import CoreData

enum TransactionDisplayType {
    case all
    case income
    case expense
}

struct DashboardView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: PaymentActivity.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \PaymentActivity.date, ascending: false) ])
    var paymentActivities: FetchedResults<PaymentActivity>
    
    @State private var showPaymentDetails = false
    @State private var editPaymentDetails = false
    
    private var totalIncome: Double {
        let total = paymentActivities
            .filter {
                $0.type == .income
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    private var totalExpense: Double {
        let total = paymentActivities
            .filter {
                $0.type == .expense
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    private var totalBalance: Double {
        return totalIncome - totalExpense
    }
    
    private var paymentDataForView: [PaymentActivity] {
        switch listType {
        case .all:
            return paymentActivities
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        case .income:
            return paymentActivities
                .filter { $0.type == .income }
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        case .expense:
            return paymentActivities
                .filter { $0.type == .expense }
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        }
    }
    
    @State private var listType: TransactionDisplayType = .all
    @State private var selectedPaymentActivity: PaymentActivity?
    
    var body: some View {
        ZStack {
            List {
                MenuBar() {
                    PaymentFormView().environment(\.managedObjectContext, self.context)
                }
                .listRowInsets(EdgeInsets())
                
                VStack {
                    TotalBalanceCard(totalBalance: totalBalance)
                        .padding(.vertical)
                    
                    HStack(spacing: 15) {
                        IncomeCard(income: totalIncome)
                        ExpenseCard(expense: totalExpense)
                    }
                    .padding(.bottom)
                    
                    TransactionHeader(listType: $listType)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .listRowInsets(EdgeInsets())
                
                // List the transaction records
                ForEach(paymentDataForView) { transaction in
                    TransactionCellView(transaction: transaction)
                        .onTapGesture {
                            self.showPaymentDetails = true
                            self.selectedPaymentActivity = transaction
                        }
                        .contextMenu {
                            Button(action: {
                                // Edit payment details
                                self.editPaymentDetails = true
                                self.selectedPaymentActivity = transaction
                                
                            }) {
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "pencil")
                                }
                            }
                            
                            Button(action: {
                                // Delete the selected payment
                                self.delete(payment: transaction)
                            }) {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                }
                .sheet(isPresented: self.$editPaymentDetails) {
                    PaymentFormView(payment: self.selectedPaymentActivity).environment(\.managedObjectContext, self.context)
                }

            }
            .offset(y: showPaymentDetails ? -100 : 0)
            .animation(.easeOut(duration: 0.2))
            
            if showPaymentDetails {
                
                BlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showPaymentDetails = false
                    }
                
                PaymentDetailView(isShow: $showPaymentDetails, payment: selectedPaymentActivity!)
                    .transition(.move(edge: .bottom))

            }
        }

    }
    
    private func delete(payment: PaymentActivity) {
        self.context.delete(payment)
        
        do {
            try self.context.save()
        } catch {
            print("Failed to save the context: \(error.localizedDescription)")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let testTrans = PaymentActivity(context: context)
        testTrans.paymentId = UUID()
        testTrans.name = "Flight ticket"
        testTrans.amount = 200.0
        testTrans.date = .today
        testTrans.type = .expense
        
        return Group {
            DashboardView().environment(\.managedObjectContext, context)

            MenuBar() {
                PaymentFormView()
            }
            .previewLayout(.sizeThatFits)
            
            TotalBalanceCard().previewLayout(.sizeThatFits)
            
            IncomeCard().previewLayout(.sizeThatFits)
            
            ExpenseCard().previewLayout(.sizeThatFits)
            
            TransactionHeader(listType: .constant(.all)).previewLayout(.sizeThatFits)
            
            TransactionCellView(transaction: testTrans).previewLayout(.sizeThatFits)
        }
    }
}

struct MenuBar<Content>: View where Content: View {
    @State private var showPaymentForm = false
    
    let modalContent: () -> Content
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Spacer()
                
                VStack(alignment: .center) {
                    Text(Date.today.string(with: "EEEE, MMM d, yyyy"))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Personal Finance")
                        .font(.title)
                        .fontWeight(.black)
                }
                
                Spacer()
            }
            
            Button(action: {
                self.showPaymentForm = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(.black)
            }

            .sheet(isPresented: self.$showPaymentForm, onDismiss: {
                self.showPaymentForm = false
            }) {
                self.modalContent()
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
    }
}

struct TotalBalanceCard: View {
    var totalBalance = 0.0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("TotalBalanceCard"))
                .cornerRadius(15.0)
         
            VStack {
                Text("Total Balance")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Text(NumberFormatter.currency(from: totalBalance))
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.1)
            }
        }
        .frame(height: 200)
        
    }
}

struct IncomeCard: View {
    var income = 0.0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("IncomeCard"))
                .cornerRadius(15.0)
         
            VStack {
                Text("Income")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Text(NumberFormatter.currency(from: income))
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.1)
            }
        }
        .frame(height: 150)
        
    }
}

struct ExpenseCard: View {
    var expense = 0.0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("ExpenseCard"))
                .cornerRadius(15.0)
         
            VStack {
                Text("Expense")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .fixedSize()
                Text(NumberFormatter.currency(from: expense))
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.1)
                
            }
        }
        .frame(height: 150)
        
    }
}

struct TransactionHeader: View {
    @Binding var listType: TransactionDisplayType
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent transactions")
                    .font(.headline)
                    .foregroundColor(Color("Heading"))
                    Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Group {
                    Text("All")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .all ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .all
                        }
                    
                    Text("Income")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .income ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .income
                        }
                    
                    Text("Expense")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .expense ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .expense
                        }
                }
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.white)
                .cornerRadius(15)
                
                Spacer()
            }
        }
    }
}

struct TransactionCellView: View {
    @ObservedObject var transaction: PaymentActivity

    var body: some View {
        
        HStack(spacing: 20) {
            
            if transaction.isFault {
                EmptyView()
           
            }  else {
            
                Image(systemName: transaction.type == .income ? "arrowtriangle.up.circle.fill" : "arrowtriangle.down.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(transaction.type == .income ? "IncomeCard" : "ExpenseCard"))
                
                VStack(alignment: .leading) {
                    Text(transaction.name)
                        .font(.system(.body, design: .rounded))
                    Text(transaction.date.string())
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                }
        
                Spacer()
                
                Text((transaction.type == .income ? "+" : "-") + NumberFormatter.currency(from: transaction.amount))
                    .font(.system(.headline, design: .rounded))
            }
        }
        .padding(.vertical, 5)
        
    }
}
