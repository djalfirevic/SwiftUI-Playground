//
//  ProfileView.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 3/24/21.
//

import SwiftUI
import Purchases
import CloudKit
import CoreData
import FirebaseAuth

struct ProfileView: View {
    @State private var showSettingsView = false
    @State private var iapButtonTitle = "Purchase Lifetime Pro Plan"
    @State private var showActionAlert = false
    @State private var alertTitle = "Purchase Successful!"
    @State private var alertMessage = "You are now a Pro member and can access all courses"
    @State var updater: Bool = false

    @Environment(\.presentationMode) var presentationMode

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)],
        predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid),
        animation: .default
    ) private var savedAccounts: FetchedResults<Account>
    @State private var currentAccount: Account?
    @State private var showLoader = false
    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        if currentAccount?.profileImage != nil {
                            GradientProfilePicture(profilePicture: UIImage(data: currentAccount!.profileImage!)!)
                                .frame(width: 66, height: 66, alignment: .center)
                        } else {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("pink-gradient-1"))
                                    .frame(width: 66, height: 66, alignment: .center)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 24, weight: .medium, design: .rounded))
                            }
                            .frame(width: 66, height: 66, alignment: .center)
                        }
                        VStack(alignment: .leading) {
                            Text(currentAccount?.name ?? "No Name")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Text("View Profile")
                                .foregroundColor(.white).opacity(0.7)
                                .font(.footnote)
                        }
                        Spacer()
                        Button {
                            showSettingsView.toggle()
                        } label: {
                            TextfieldIcon(iconName: "gearshape.fill", passedImage: .constant(nil), currentlyEditing: .constant(true))
                        }
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                    Text(currentAccount?.bio ?? "No Bio")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    if currentAccount?.numberOfCertificates != 0 {
                        Label(
                            title: { Text("Awarded \(currentAccount?.numberOfCertificates ?? 100) certificates since \(dateFormatter(currentAccount?.userSince ?? Date()))") },
                            icon: { Image(systemName: "calendar") }
                        )
                        .foregroundColor(.white).opacity(0.7)
                        .font(.footnote)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                    }
                    HStack(spacing: 16) {
                        if currentAccount?.twitterHandle != nil {
                            Image("Twitter")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        if currentAccount?.website != nil {
                            Image(systemName: "link")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 17, weight: .semibold))
                            Text(currentAccount?.website ?? "No website")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.footnote)
                        }
                    }
                }
                .padding(16)
                GradientButton(buttonTitle: iapButtonTitle) {
                    if !(currentAccount?.proMember ?? true) {
                        // Purchase
                        showLoader = true
                        Purchases.shared.offerings { (offerings, error) in
                            if let packages = offerings?.current?.availablePackages {
                                Purchases.shared.purchasePackage(packages.first!) { (transaction, purchaserInfo, error, userCancelled) in
                                    print("TRANSACTION: \(String(describing: transaction))")
                                    print("PURCHASERINFO: \(String(describing: purchaserInfo))")
                                    print("ERROR: \(String(describing: error))")
                                    print("USERCANCELLED: \(userCancelled)")
                                    if purchaserInfo?.entitlements["Pro"]?.isActive == true {
                                        // Unlock that great "pro" content
                                        currentAccount?.proMember = true
                                        iapButtonTitle = "You are a Pro Member"
                                        do {
                                            try viewContext.save()
                                            alertTitle = "Purchase Successful"
                                            alertMessage = "Your purchases have been restored"
                                            showActionAlert.toggle()
                                        } catch let error {
                                            alertTitle = "Uh-oh!"
                                            alertMessage = "Your purchase was successful but not synced to iCloud. \(error.localizedDescription)"
                                            showActionAlert.toggle()
                                        }
                                        showLoader = false
                                    } else {
                                        alertTitle = "Purchase Failed"
                                        alertMessage = String(describing: error)
                                        showActionAlert.toggle()
                                        showLoader = false
                                    }
                                }
                            } else {
                                showLoader = false
                            }
                        }
                    } else {
                        showLoader = false
                        alertTitle = "Purchase Successful!"
                        alertMessage = "You are now a Pro member and can access all courses"
                        showActionAlert.toggle()
                    }
                    
                }
                .alert(isPresented: $showActionAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
                })
                
                .padding(.horizontal, 16)
                
                Button {
                    showLoader = true
                    Purchases.shared.restoreTransactions { (purchaserInfo, error) in
                        if let info = purchaserInfo {
                            if info.allPurchasedProductIdentifiers.contains("lifetime_pro_plan") {
                                currentAccount?.proMember = true
                                iapButtonTitle = "You are a Pro Member"
                                do {
                                    try viewContext.save()
                                    alertTitle = "Restore Successful"
                                    alertMessage = "Your purchases have been restored"
                                    showActionAlert.toggle()
                                } catch let error {
                                    alertTitle = "Uh-oh!"
                                    alertMessage = "Your purchases have been restored but the data has not been saved. \(error.localizedDescription)"
                                    showActionAlert.toggle()
                                }
                                showLoader = false
                            } else {
                                currentAccount?.proMember = false
                                do {
                                    try viewContext.save()
                                    alertTitle = "Restore Unsuccessful"
                                    alertMessage = error?.localizedDescription ?? "No previous purchases found to restore"
                                    showActionAlert.toggle()
                                } catch let error {
                                    alertTitle = "Restore Unsuccessful"
                                    alertMessage = error.localizedDescription
                                    showActionAlert.toggle()
                                }
                                showLoader = false
                            }
                        } else {
                            showLoader = false
                        }
                    }
                } label: {
                    GradientText(text: "Restore Purchases")
                        .font(Font.footnote.bold())
                }
                    .padding(.bottom)
                    
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .dark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
            VStack{
                Spacer()
                Button {
                    signOut()
                } label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 0, z: 1))
                        .background(
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(
                                    VisualEffectBlur(blurStyle: .dark)
                                        .cornerRadius(20)
                                        .frame(width: 40, height: 40, alignment: .center)
                                )
                        )

                }

            }
            .padding(.bottom, 64)
            
            if showLoader {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .sheet(isPresented: $showSettingsView, content: {
            SettingsView()
                .environment(\.managedObjectContext, self.viewContext)
                .colorScheme(.dark)
                .onDisappear {
                    currentAccount = savedAccounts.first!
                    updater.toggle()
                }
        })
        .colorScheme(updater ? .dark : .dark)
        .onAppear() {
            // Check CloudKit
            currentAccount = savedAccounts.first

            if currentAccount == nil {
                let userDataToSave = Account(context: viewContext)
                userDataToSave.name = Auth.auth().currentUser!.displayName
                userDataToSave.userID = Auth.auth().currentUser!.uid
                userDataToSave.bio = nil
                userDataToSave.numberOfCertificates = 0
                userDataToSave.userSince = Date()
                userDataToSave.proMember = false
                userDataToSave.twitterHandle = nil
                userDataToSave.website = nil
                userDataToSave.profileImage = nil
                do {
                    try viewContext.save()
                } catch let error {
                    alertTitle = "Could not save user data"
                    alertMessage = error.localizedDescription
                }
            }
            
            // Check Pro User
            if !currentAccount!.proMember {
                Purchases.shared.offerings { (offerings, error) in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let allOfferings = offerings, let lifetimePurchase = allOfferings.current?.lifetime {
                        iapButtonTitle = "Purchase Lifetime Pro Plan - \(lifetimePurchase.localizedPriceString)"
                    }
                }
            } else {
                iapButtonTitle = "You are a Pro Member"
            }
        }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            presentationMode.wrappedValue.dismiss()
        } catch let error {
            alertTitle = "Could not log out"
            alertMessage = error.localizedDescription
            showActionAlert.toggle()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
