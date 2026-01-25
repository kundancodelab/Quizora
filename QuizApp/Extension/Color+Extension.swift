//
//  Color+Extension.swift
//  QuizApp
//
//  Created by User on 25/01/26.
//

import Foundation

import SwiftUI

// MARK: - App Theme Colors (Premium Purple Gradient)
let appTint: Color = Color(hex: "#8B5CF6") // Vibrant purple

// Premium purple gradient for buttons and highlights (matching screenshot mockups)
let appGradient = LinearGradient(
    colors: [Color(hex: "#8B5CF6"), Color(hex: "#6366F1"), Color(hex: "#4F46E5")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

// Softer purple gradient for backgrounds
let softPurpleGradient = LinearGradient(
    colors: [Color(hex: "#EDE9FE"), Color(hex: "#DDD6FE")],
    startPoint: .top,
    endPoint: .bottom
)

// Deep purple gradient for dark mode
let deepPurpleGradient = LinearGradient(
    colors: [Color(hex: "#4C1D95"), Color(hex: "#5B21B6")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

// Semantic colors for light/dark mode (with purple tint)
extension Color {
    static let cardBackground = Color(light: .white, dark: Color(hex: "#1C1C1E"))
    static let screenBackground = Color(light: Color(hex: "#FAF5FF"), dark: Color(hex: "#0F0A1A")) // Light purple tint
    static let secondaryBackground = Color(light: Color(hex: "#EDE9FE"), dark: Color(hex: "#2D2438"))
    static let purpleAccent = Color(hex: "#8B5CF6")
    static let indigoAccent = Color(hex: "#6366F1")
}

// MARK: - Color Initializer for Light/Dark
extension Color {
    init(light: Color, dark: Color) {
        #if os(iOS)
        self.init(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
        #else
        self.init(nsColor: NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? NSColor(dark) : NSColor(light)
        } ?? NSColor(light))
        #endif
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Exam Category Colors (Premium palette)
extension ExamCategory {
    var color: Color {
        switch self {
        case .upsc, .bpsc, .uppsc: return .purple
        case .ssc: return .indigo
        case .railway: return Color(hex: "#E85D04")
        case .banking, .insurance: return Color(hex: "#2D6A4F")
        case .defense: return Color(hex: "#9D0208")
        case .neet, .aiims: return Color(hex: "#D90429")
        case .gate, .isro, .drdo: return Color(hex: "#F77F00")
        case .ugcNet, .ctet, .kvs: return Color(hex: "#7209B7")
        case .judiciary, .clat: return Color(hex: "#3A0CA3")
        case .cat, .ca: return Color(hex: "#4361EE")
        case .gre, .gmat, .toefl: return Color(hex: "#4CC9F0")
        default: return .gray
        }
    }
    
    /// Returns the logo asset name if available, nil otherwise
    var logoImageName: String? {
        switch self {
        case .upsc, .bpsc, .uppsc: return "UPSClogo"
        case .ssc: return "SSCLogo"
        case .railway: return "RailwaysLogo"
        case .banking, .insurance: return "BankLogo"
        case .neet, .aiims: return "NEETLogo"
        case .gate, .isro, .drdo: return "JEELogo"  // Using JEE logo for technical exams
        case .defense: return "POLICELogo"  // Using Police logo for defense
        default: return nil
        }
    }
}

// MARK: - Exam Status Colors
extension ExamStatus {
    var statusColor: Color {
        switch self {
        case .applied: return .blue
        case .admitCardOut: return .orange
        case .examCompleted: return .purple
        case .resultOut: return .indigo
        case .selected: return Color(hex: "#2D6A4F")
        case .notSelected: return Color(hex: "#D90429")
        }
    }
}

// MARK: - Date Formatting Helper
func format(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

// MARK: - Premium UI Modifiers

/// Glassmorphism card style with frosted glass effect
struct GlassmorphismModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var opacity: Double = 0.7
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .opacity(opacity)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.3), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

/// Premium shadow with glow effect
struct PremiumShadowModifier: ViewModifier {
    var color: Color = .purple
    var radius: CGFloat = 12
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.15), radius: radius, x: 0, y: 4)
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}

/// Tap scale animation
struct TapScaleModifier: ViewModifier {
    @State private var isPressed = false
    var scale: CGFloat = 0.97
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}

/// Pulse animation for badges
struct PulseAnimationModifier: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 0.9 : 1.0)
            .animation(
                .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear { isPulsing = true }
    }
}

// MARK: - View Extensions for Premium Modifiers
extension View {
    /// Apply glassmorphism (frosted glass) effect
    func glassmorphism(cornerRadius: CGFloat = 16, opacity: Double = 0.7) -> some View {
        modifier(GlassmorphismModifier(cornerRadius: cornerRadius, opacity: opacity))
    }
    
    /// Apply premium shadow with optional glow color
    func premiumShadow(color: Color = .purple, radius: CGFloat = 12) -> some View {
        modifier(PremiumShadowModifier(color: color, radius: radius))
    }
    
    /// Apply tap scale animation for interactive feedback
    func tapScale(_ scale: CGFloat = 0.97) -> some View {
        modifier(TapScaleModifier(scale: scale))
    }
    
    /// Apply subtle pulse animation (great for badges)
    func pulseAnimation() -> some View {
        modifier(PulseAnimationModifier())
    }
}

// MARK: - Tap Scale Button Style
struct TapScaleButtonStyle: ButtonStyle {
    var scale: CGFloat = 0.97
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Premium Gradients
let premiumGoldGradient = LinearGradient(
    colors: [Color(hex: "#FFD700"), Color(hex: "#FFA500")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

let premiumBlueGradient = LinearGradient(
    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

let premiumGreenGradient = LinearGradient(
    colors: [Color(hex: "#11998e"), Color(hex: "#38ef7d")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
