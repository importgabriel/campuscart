// Views/Onboarding/OnboardingView.swift

import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case credentials, name, year, major, photo
}

struct OnboardingView: View {
    @State private var step: OnboardingStep = .credentials

    // Credentials
    @State private var email    = ""
    @State private var password = ""
    @State private var userId: UUID?

    // Profile info
    @State private var name         = ""
    @State private var year         = ""
    @State private var major        = ""
    @State private var profileImage: UIImage?

    @State private var errorMessage: String?

    var body: some View {
        VStack {
            ProgressView(
                value: Double(step.rawValue + 1),
                total: Double(OnboardingStep.allCases.count)
            )
            .padding()

            switch step {
            case .credentials:
                CredentialsStepView(
                    email: $email,
                    password: $password,
                    onNext: { Task { await signUp() } }
                )

            case .name:
                NameStepView(name: $name) {
                    advance()
                }

            case .year:
                YearStepView(year: $year) {
                    advance()
                }

            case .major:
                MajorStepView(major: $major) {
                    advance()
                }

            case .photo:
                PhotoStepView(image: $profileImage) {
                    Task { await finish() }
                }
            }

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 8)
            }
        }
        .padding()
        .animation(.easeInOut, value: step)
    }

    private func advance() {
        if let next = OnboardingStep(rawValue: step.rawValue + 1) {
            step = next
            errorMessage = nil
        }
    }

    @MainActor
    private func signUp() async {
        // 1. Validate .edu email
        guard email.lowercased().hasSuffix(".edu") else {
            errorMessage = "Please use a .edu email address."
            return
        }

        do {
            // 2. Call your AuthService.signUp
            let response = try await AuthService.shared.signUp(
                email: email,
                password: password
            )
            // 3. Capture the new user's UUID
            userId = response.user.id
            // 4. Advance to the next step
            advance()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    private func finish() async {
        // Ensure we have a signed-up user
        guard let userUUID = userId else {
            errorMessage = "Unexpected error: no user ID."
            return
        }

        // Convert year string to Int if possible
        let gradYearInt = Int(year)

        do {
            // Insert their profile record
            try await AuthService.shared.insertUserProfile(
                id: userUUID,
                name: name,
                school: "YourSchoolHere",     // swap in actual school if collected
                major: major,
                graduationYear: gradYearInt,
                bio: nil,
                profileImageURL: nil
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
