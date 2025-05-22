//
//  AuthServices.swift
//  CampusCart
//
//  Created by wayne on 5/19/25.
//

// Services/AuthService.swift

import Supabase
import Foundation

final class AuthService: ObservableObject {
    static let shared = AuthService()
    
    let supabaseClient: SupabaseClient
    
    private init() {
        
        guard
            let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
            let key       = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY_ANON") as? String,
            let url       = URL(string: urlString)
        else {
            fatalError("❌ Supabase config missing or invalid in Info.plist")
        }
        
        
        supabaseClient = SupabaseClient(
            supabaseURL: url,
            supabaseKey: key
        )
    }
    
    
    
    func signUp(email: String, password: String) async throws -> AuthResponse {
        guard email.lowercased().hasSuffix(".edu") else {
            throw AuthError.invalidEmailDomain
        }
        
        
        let response = try await supabaseClient.auth.signUp(
            email: email,
            password: password
        )
        
        return response
    }
    
    func signIn(email: String, password: String) async throws -> Session {
        
        guard email.lowercased().hasSuffix(".edu") else {
            throw AuthError.invalidEmailDomain
        }
        let response = try await supabaseClient.auth.signIn(
            email: email,
            password: password
        )
        
        return response
    }
    struct UserProfile: Codable {
        let id: String
        let name: String
        let school: String
        let major: String?
        let graduation_year: Int?
        let bio: String?
        let profile_image_url: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, school, major, bio
            case graduation_year
            case profile_image_url
        }
    }
    
    @MainActor
    func insertUserProfile(
        id: UUID,
        name: String,
        school: String,
        major: String? = nil,
        graduationYear: Int? = nil,
        bio: String? = nil,
        profileImageURL: String? = nil
    ) async throws {
        // Build your Encodable payload
        let profile = UserProfile(
            id:                id.uuidString,
            name:              name,
            school:            school,
            major:             major,
            graduation_year:   graduationYear,
            bio:               bio,
            profile_image_url: profileImageURL
        )
        
        // Perform the insert — this will throw if there's an error
        _ = try await supabaseClient
            .from("users")
            .insert(profile)
            .execute()
    }
    
    
    enum AuthError: Error {
        case invalidEmailDomain
    }
}

