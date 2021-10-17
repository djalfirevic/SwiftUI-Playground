//
//  SettingsView.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 3/24/21.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @State private var editingNameTextfield = false
    @State private var nameIconBounce = false
    @State private var name = ""
    @State private var editingTwitterTextfield = false
    @State private var twitterIconBounce = false
    @State private var twitter = ""
    @State private var editingSiteTextfield = false
    @State private var siteIconBounce = false
    @State private var site = ""
    @State private var editingBioTextfield = false
    @State private var bioIconBounce = false
    @State private var bio = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showActionAlert = false
    @State private var alertTitle = "Settings Saved!"
    @State private var alertMessage = "Your changes have been saved"

    private let generator = UISelectionFeedbackGenerator()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)],
        predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid),
        animation: .default
    ) private var savedAccounts: FetchedResults<Account>
    @State private var currentAccount: Account?
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 16) {
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                Text("Manage your Design+Code profile and account")
                    .font(.callout)
                    .foregroundColor(Color.white.opacity(0.7))
                // Choose Photo
                Button {
                    self.showingImagePicker = true
                } label: {
                    HStack(spacing: 12) {
                        TextfieldIcon(iconName: "person.crop.circle", passedImage: $inputImage, currentlyEditing: .constant(false))
                        GradientText(text: "Choose Photo")
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .background(
                        Color.init(red: 26/255, green: 20/255, blue: 51/255)
                            .cornerRadius(16)
                    )
                }
                
                // Name Text Field
                GradientTextfield(editingTextfield: $editingNameTextfield, textfieldString: $name, iconBounce: $nameIconBounce, textfieldPlaceholder: "Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                // Twitter Text Field
                GradientTextfield(editingTextfield: $editingTwitterTextfield, textfieldString: $twitter, iconBounce: $twitterIconBounce, textfieldPlaceholder: "Twitter Handle", textfieldIconString: "at")
                    .autocapitalization(.none)
                    .keyboardType(.twitter)
                    .disableAutocorrection(true)
                
                // Site Text Field
                GradientTextfield(editingTextfield: $editingSiteTextfield, textfieldString: $site, iconBounce: $siteIconBounce, textfieldPlaceholder: "Website", textfieldIconString: "link")
                    .autocapitalization(.none)
                    .keyboardType(.webSearch)
                    .disableAutocorrection(true)
                
                // Bio Text View
                GradientTextfield(editingTextfield: $editingBioTextfield, textfieldString: $bio, iconBounce: $bioIconBounce, textfieldPlaceholder: "Bio", textfieldIconString: "text.justifyleft")
                    .autocapitalization(.sentences)
                    .keyboardType(.default)
                
                GradientButton(buttonTitle: "Save Settings") {
                    generator.selectionChanged()
                    currentAccount?.name = self.name
                    currentAccount?.bio = self.bio
                    currentAccount?.twitterHandle = self.twitter
                    currentAccount?.profileImage = self.inputImage?.pngData()
                    currentAccount?.website = self.site
                    do {
                        try viewContext.save()
                        alertTitle = "Settings Saved!"
                        alertMessage = "Your changes have been saved"
                        showActionAlert.toggle()
                    } catch let error {
                        alertTitle = "Uh-oh!"
                        alertMessage = "Your changes could not be saved. " + error.localizedDescription
                        showActionAlert.toggle()
                    }
                }
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .background(
            Color("settingsBackground")
                .edgesIgnoringSafeArea(.all)
        )
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .alert(isPresented: $showActionAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
        })
        .onAppear() {
            // Check CloudKit
            currentAccount = savedAccounts.first!
            self.name = currentAccount?.name ?? ""
            self.bio = currentAccount?.bio ?? ""
            self.twitter = currentAccount?.twitterHandle ?? ""
            self.site = currentAccount?.website ?? ""
            self.inputImage = UIImage(data: currentAccount?.profileImage ?? Data())
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

