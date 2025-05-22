import SwiftUI

struct LoginPage: View {
    @State private var email       = ""
    @State private var password    = ""
    @State private var errorMessage: String?
    
    // Navigation flags
    @State private var navigateToHome = false
    @State private var navigateToOnboarding = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("CampusCart Sign In")
                    .font(.title2).bold()

                TextField("Email (.edu only)", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                HStack(spacing: 16) {
                    // SIGN IN: actually calls your AuthService
                    Button("Sign In") {
                        Task { await performSignIn() }
                    }
                    .buttonStyle(.borderedProminent)

                    // SIGN UP: simply navigates to onboarding
                    Button("Sign Up") {
                        navigateToOnboarding = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            // navigationDestination for each flag
            .navigationDestination(isPresented: $navigateToHome) {
                ContentView()
            }
            .navigationDestination(isPresented: $navigateToOnboarding) {
                OnboardingView()
            }
        }
    }

    @MainActor
    private func performSignIn() async {
        guard email.lowercased().hasSuffix(".edu") else {
            errorMessage = "Please use a .edu email address."
            return
        }
        do {
            _ = try await AuthService.shared.signIn(email: email, password: password)
            errorMessage = nil
            navigateToHome = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
