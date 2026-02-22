//
//  AppleAuthService.swift
//  StateObg-ObservedObjLearning
//
//  Created by User on 14/09/25.
//
//
//  AppleAuthService.swift
//  StateObg-ObservedObjLearning
//
//  Created by User on 14/09/25.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import UIKit

final class AppleAuthService: NSObject, AppleAuthServiceProtocol, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let auth = Auth.auth()
    private var currentNonce: String?
    private var completion: ((Result<FirebaseAuth.User, Error>) -> Void)?
    
    func signIn(completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        print("🟢 Apple Sign-In started")
        self.completion = completion
        
        let nonce = GenerateRandomNonce().randomNonceString()
        currentNonce = nonce
        print("🟢 Nonce generated: \(nonce)")
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = GenerateRandomNonce().sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        print("🟢 Apple controller performRequests called")
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("🟢 Apple authorization completed successfully")
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("🔴 Failed to get Apple credentials - invalid credential type")
            completion?(.failure(AuthError.invalidCredential))
            return
        }
        
        guard let nonce = currentNonce else {
            print("🔴 Failed to get nonce")
            completion?(.failure(AuthError.invalidCredential))
            return
        }
        
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("🔴 Failed to get Apple ID token")
            completion?(.failure(AuthError.invalidCredential))
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("🔴 Failed to convert Apple ID token to string")
            completion?(.failure(AuthError.invalidCredential))
            return
        }
        
        print("🟢 Apple ID Token received successfully")
        
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("🔴 Firebase sign-in failed: \(error.localizedDescription)")
                self?.completion?(.failure(error))
            } else if let user = authResult?.user {
                print("🟢 Firebase sign-in successful, user UID: \(user.uid)")
                self?.completion?(.success(user))
            } else {
                print("🔴 Unknown Firebase error - no user and no error")
                self?.completion?(.failure(AuthError.unknownError))
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("🔴 Apple authorization failed: \(error.localizedDescription)")
        completion?(.failure(error))
    }
    
    // MARK: - ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("No key window found for Apple Sign-In")
        }
        return window
    }
  
}





final class AppleAuthService_Simple: NSObject, AppleAuthServiceProtocol, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private var completion: ((Result<FirebaseAuth.User, Error>) -> Void)?
    
    func signIn(completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        print("🟢 Starting Apple Sign-In")
        self.completion = completion
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("🟢 Apple Sign-In successful")
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            completion?(.failure(NSError(domain: "AppleSignIn", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credential"])))
            return
        }
        
        // For demo purposes without paid account, we'll use a workaround
        // Create a real Firebase user with email/password instead
        createDemoFirebaseUser(appleCredential: appleIDCredential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("🔴 Apple Sign-In failed: \(error.localizedDescription)")
        completion?(.failure(error))
    }
    
    // MARK: - Demo Workaround (since real Apple Sign-In requires paid account)
    private func createDemoFirebaseUser(appleCredential: ASAuthorizationAppleIDCredential) {
        let email = appleCredential.email ?? "apple_demo_\(UUID().uuidString.prefix(8))@example.com"
        let password = "DemoPassword123!" // Standard password for demo
        let displayName = "\(appleCredential.fullName?.givenName ?? "Apple") \(appleCredential.fullName?.familyName ?? "User")"
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // If user already exists, try to sign in
                if (error as NSError).code == 17007 {
                    self?.signInWithDemoCredentials(email: email, password: password, displayName: displayName)
                } else {
                    self?.completion?(.failure(error))
                }
            } else if let user = authResult?.user {
                // Update user profile with display name
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { _ in
                    self?.completion?(.success(user))
                }
            } else {
                self?.completion?(.failure(NSError(domain: "AppleSignIn", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
            }
        }
    }
    
    private func signInWithDemoCredentials(email: String, password: String, displayName: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.completion?(.failure(error))
            } else if let user = authResult?.user {
                self?.completion?(.success(user))
            } else {
                self?.completion?(.failure(NSError(domain: "AppleSignIn", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
            }
        }
    }
    
    // MARK: - ASAuthorizationControllerPresentationContextProviding
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("No key window found")
        }
        return window
    }
}
