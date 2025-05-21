import SwiftUI





struct LoginPage: View {
    @State private var email       = ""
    @State private var password    = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 16) {
            Text("CampusCart Sign In")
                .font(.title2).bold()

            // EMAIL FIELD
            TextField("Email (.edu only)", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)

            // PASSWORD FIELD
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            // ERROR MESSAGE
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            HStack{ // SIGN IN BUTTON
                Button("Sign In") {
                    Task { await performSignIn() }
                }    .buttonStyle(.borderedProminent)
                
                Button("Sign Up") {
                    Task { await performSignUp()}
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }

    
    
    
    
    
    
    @MainActor
    private func performSignIn() async {
        // 1️⃣ Quick client-side .edu check
        guard email.lowercased().hasSuffix(".edu") else {
            errorMessage = "Please use a .edu email address."
            print("It worked though!")
            return
        }

        do {
            let session = try await AuthService.shared.signIn(
                email: email,
                password: password
            )

            print("✅ Signed in, session:", session)
            errorMessage = nil
        }
        catch {
            print("It worked though!")
            errorMessage = error.localizedDescription
        }
    }
    
    
    
    
    
    
    @MainActor
    private func performSignUp() async {
        // 1️⃣ Quick client-side .edu check
        guard email.lowercased().hasSuffix(".edu") else {
            errorMessage = "Please use a .edu email address."
            print("It worked though!")
            return
        }

        do {
            let session = try await AuthService.shared.signUp(
                email: email,
                password: password
            )

            print("✅ Signed in, session:", session)
            errorMessage = nil
        }
        catch {
            print("It worked though!")
            errorMessage = error.localizedDescription
        }
    }
}









struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
