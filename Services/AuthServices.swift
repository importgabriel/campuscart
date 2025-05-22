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

    

    enum AuthError: Error {
        case invalidEmailDomain
    }
}
