// ContentView.swift
// KyvshieldLiteExample
//
// Pixel-perfect SwiftUI port of the Flutter Lite example app.
// Design system, localization strings, layout order, and interaction
// all match the Flutter reference exactly.
//
// Requires:
//   - KyvshieldLite (local Swift Package from ../../KyvshieldLite)
//   - Photos.framework  (save to gallery)
//   - AVFoundation.framework (camera permission)

import SwiftUI
import AVFoundation
import Photos
import KyvshieldLite

// MARK: - ChallengeMode (local mirror)
// Already defined in the SDK — re-used here for convenience.

// MARK: - AppBrightness

enum AppBrightness: String, CaseIterable {
    case light, dark, auto
}

// MARK: - AppTheme

enum AppTheme: String, CaseIterable {
    case `default`, blue, green, purple, kratos, luna, custom

    var color: Color {
        switch self {
        case .default: return Color(hex: "EF8352")
        case .blue:    return Color(hex: "3B82F6")
        case .green:   return Color(hex: "10B981")
        case .purple:  return Color(hex: "8B5CF6")
        case .kratos:  return Color(hex: "00377D")
        case .luna:    return Color(hex: "FFD100")
        case .custom:  return Color(hex: "EF8352") // replaced at runtime
        }
    }
}

// MARK: - KyvshieldDocument + Identifiable

// No @retroactive Identifiable — use ForEach(items, id: \.keyPath) instead

// MARK: - Localization strings

private let exampleStrings: [String: [String: String]] = [
    "fr": [
        "appTitle": "KyvShield Demo",
        "captureSteps": "Étapes de capture",
        "selfie": "Selfie",
        "selfieDesc": "Photo du visage",
        "recto": "Recto",
        "rectoDesc": "Face avant du document",
        "verso": "Verso",
        "versoDesc": "Face arrière du document",
        "flowOptions": "Options du flow",
        "introPage": "Page d'introduction",
        "introPageDesc": "Afficher la page d'accueil explicative",
        "instructionPages": "Pages d'instruction",
        "instructionPagesDesc": "Afficher les instructions avant chaque étape",
        "resultPage": "Page de résultat",
        "resultPageDesc": "Afficher le résumé final (sinon retour direct)",
        "successPerStep": "Succès par étape",
        "successPerStepDesc": "Animation de succès après chaque étape",
        "faceMatch": "Face Match",
        "faceMatchDesc": "Comparer le selfie avec la photo du document",
        "challengeAudio": "Audio des challenges",
        "challengeAudioDesc": "Jouer les instructions audio pour chaque challenge",
        "language": "Langue",
        "securityLevel": "Niveau de sécurité",
        "displayMode": "Mode d'affichage",
        "selfieDisplay": "Affichage selfie",
        "documentDisplay": "Affichage document",
        "document": "Document",
        "allCountries": "Tous les pays",
        "autoDetect": "Détection automatique",
        "autoDetectDesc": "Claude détectera le type de document automatiquement",
        "apiOptions": "Options API",
        "apiUrl": "URL de l'API",
        "apiKey": "Clé API",
        "kycIdentifier": "Identifiant KYC",
        "kycIdentifierHint": "Optionnel: votre référence interne",
        "theme": "Thème",
        "themeMode": "Mode",
        "light": "Clair",
        "dark": "Sombre",
        "auto": "Auto",
        "startVerification": "Démarrer la vérification",
        "configSummary": "Résumé de la configuration",
        "noStepSelected": "Aucune étape sélectionnée",
        "lastResult": "Dernier résultat",
        "success": "Succès",
        "failed": "Échoué",
        "resultDetails": "Détails du résultat",
        "noResult": "Aucun résultat disponible",
        "loading": "Chargement...",
        "error": "Erreur",
        "selectAtLeastOneStep": "Sélectionnez au moins une étape",
        "documentType": "Type de document",
        "noDocumentAvailable": "Aucun document disponible",
        "selectDocument": "Sélectionner un document",
        "rectoVerso": "Recto + Verso",
        "rectoOnly": "Recto uniquement",
        "rectoOnlySupported": "ne supporte que le recto",
        "captureOptions": "Options de capture",
        "display": "Affichage",
        "selectAtLeastOneStepAbove": "Sélectionnez au moins une étape ci-dessus",
        "flowOptionsSection": "Options de flux",
        "configuredFlow": "Flux configuré:",
        "noStepConfigured": "Aucune étape configurée",
        "starting": "Démarrage...",
        "custom": "Custom",
        "customColor": "Couleur personnalisée",
        "cancel": "Annuler",
        "apply": "Appliquer",
        "themeInnolink": "Innolink",
        "themeBlue": "Bleu",
        "themeGreen": "Vert",
        "themePurple": "Violet",
        "themeKratos": "Kratos",
        "themeLuna": "Luna",
        "verificationCompleteSuccess": "Vérification complète réussie",
        "verificationFailed": "Vérification échouée",
        "documentsVerified": "Documents vérifiés",
        "documentVerificationFailed": "Vérification documents échouée",
        "rectoFaceVerified": "Recto + Face vérifiés",
        "rectoVerified": "Recto vérifié",
        "rectoVerificationFailed": "Vérification recto échouée",
        "versoVerified": "Verso vérifié",
        "versoVerificationFailed": "Vérification verso échouée",
        "selfieCaptured": "Selfie capturé",
        "selfieFailed": "Selfie échoué",
        "completed": "Terminé",
        "cancelled": "Annulé",
        "authenticityScore": "Score d'authenticité",
        "scannedDocuments": "Documents scannés",
        "extractedPhotos": "Photos extraites du document",
        "extractedPhoto": "Photo extraite",
        "humanFace": "Visage Humain",
        "faceMatchResult": "Visage correspondant",
        "faceNoMatchResult": "Visage non correspondant",
        "componentScores": "Scores des composants",
        "overallScore": "Score Global",
        "liveness": "Vivacité",
        "processingTime": "Temps de traitement",
        "total": "Total",
        "imageSavedToGallery": "Image enregistrée dans la galerie",
        "cameraRequired": "Caméra requise",
        "cameraAccessDenied": "L'accès à la caméra a été refusé. Veuillez l'activer dans les réglages de votre appareil.",
        "openSettings": "Ouvrir les réglages",
        "selfieDisplayStandard": "Standard",
        "selfieDisplayCompact": "Compact",
        "selfieDisplayImmersive": "Immersif",
        "challengeBottom": "Challenge en bas",
        "challengeOnCamera": "Challenge sur caméra",
        "fullScreen": "Plein écran",
        "docDisplayStandard": "Standard",
        "docDisplayCompact": "Compact",
        "docDisplayImmersive": "Immersif",
        "instructionsBottom": "Instructions en bas",
        "instructionsOnCamera": "Instructions sur caméra",
        "mrz": "MRZ (Machine Readable Zone)",
        "fields": "champs",
        "noExtractedData": "Aucune donnée extraite",
        "none": "Aucun",
        "result": "Résultat",
        "notDetected": "Non détecté",
        "threshold": "Seuil",
        "selfieCapturedNoAnalysis": "Selfie capturé avec succès. Aucune analyse de document effectuée.",
        "errorDecodeImage": "Erreur: impossible de décoder l'image",
        "intro": "Intro",
        "instructions": "Instructions",
        "amlScreening": "Screening AML / Sanctions",
        "amlStatus": "Statut",
        "amlRiskLevel": "Niveau de risque",
        "amlMatches": "Correspondances",
        "amlClear": "Aucune correspondance",
        "amlMatch": "Correspondance trouvée",
        "amlError": "Erreur de screening",
        "amlDisabled": "Désactivé",
    ],
    "en": [
        "appTitle": "KyvShield Demo",
        "captureSteps": "Capture Steps",
        "selfie": "Selfie",
        "selfieDesc": "Face photo",
        "recto": "Recto",
        "rectoDesc": "Document front side",
        "verso": "Verso",
        "versoDesc": "Document back side",
        "flowOptions": "Flow Options",
        "introPage": "Introduction Page",
        "introPageDesc": "Show explanatory welcome page",
        "instructionPages": "Instruction Pages",
        "instructionPagesDesc": "Show instructions before each step",
        "resultPage": "Result Page",
        "resultPageDesc": "Show final summary (otherwise direct return)",
        "successPerStep": "Success Per Step",
        "successPerStepDesc": "Success animation after each step",
        "faceMatch": "Face Match",
        "faceMatchDesc": "Compare selfie with document photo",
        "challengeAudio": "Challenge Audio",
        "challengeAudioDesc": "Play audio instructions for each challenge",
        "language": "Language",
        "securityLevel": "Security Level",
        "displayMode": "Display Mode",
        "selfieDisplay": "Selfie Display",
        "documentDisplay": "Document Display",
        "document": "Document",
        "allCountries": "All Countries",
        "autoDetect": "Auto Detect",
        "autoDetectDesc": "Claude will detect the document type automatically",
        "apiOptions": "API Options",
        "apiUrl": "API URL",
        "apiKey": "API Key",
        "kycIdentifier": "KYC Identifier",
        "kycIdentifierHint": "Optional: your internal reference",
        "theme": "Theme",
        "themeMode": "Mode",
        "light": "Light",
        "dark": "Dark",
        "auto": "Auto",
        "startVerification": "Start Verification",
        "configSummary": "Configuration Summary",
        "noStepSelected": "No step selected",
        "lastResult": "Last Result",
        "success": "Success",
        "failed": "Failed",
        "resultDetails": "Result Details",
        "noResult": "No result available",
        "loading": "Loading...",
        "error": "Error",
        "selectAtLeastOneStep": "Select at least one step",
        "documentType": "Document Type",
        "noDocumentAvailable": "No document available",
        "selectDocument": "Select a document",
        "rectoVerso": "Front + Back",
        "rectoOnly": "Front only",
        "rectoOnlySupported": "only supports front side",
        "captureOptions": "Capture Options",
        "display": "Display",
        "selectAtLeastOneStepAbove": "Select at least one step above",
        "flowOptionsSection": "Flow Options",
        "configuredFlow": "Configured flow:",
        "noStepConfigured": "No step configured",
        "starting": "Starting...",
        "custom": "Custom",
        "customColor": "Custom Color",
        "cancel": "Cancel",
        "apply": "Apply",
        "themeInnolink": "Innolink",
        "themeBlue": "Blue",
        "themeGreen": "Green",
        "themePurple": "Purple",
        "themeKratos": "Kratos",
        "themeLuna": "Luna",
        "verificationCompleteSuccess": "Full verification successful",
        "verificationFailed": "Verification failed",
        "documentsVerified": "Documents verified",
        "documentVerificationFailed": "Document verification failed",
        "rectoFaceVerified": "Front + Face verified",
        "rectoVerified": "Front verified",
        "rectoVerificationFailed": "Front verification failed",
        "versoVerified": "Back verified",
        "versoVerificationFailed": "Back verification failed",
        "selfieCaptured": "Selfie captured",
        "selfieFailed": "Selfie failed",
        "completed": "Completed",
        "cancelled": "Cancelled",
        "authenticityScore": "Authenticity Score",
        "scannedDocuments": "Scanned Documents",
        "extractedPhotos": "Photos extracted from document",
        "extractedPhoto": "Extracted photo",
        "humanFace": "Human Face",
        "faceMatchResult": "Face match",
        "faceNoMatchResult": "Face mismatch",
        "componentScores": "Component Scores",
        "overallScore": "Overall Score",
        "liveness": "Liveness",
        "processingTime": "Processing Time",
        "total": "Total",
        "imageSavedToGallery": "Image saved to gallery",
        "cameraRequired": "Camera Required",
        "cameraAccessDenied": "Camera access was denied. Please enable it in your device settings to continue verification.",
        "openSettings": "Open Settings",
        "selfieDisplayStandard": "Standard",
        "selfieDisplayCompact": "Compact",
        "selfieDisplayImmersive": "Immersive",
        "challengeBottom": "Challenge at bottom",
        "challengeOnCamera": "Challenge on camera",
        "fullScreen": "Full screen",
        "docDisplayStandard": "Standard",
        "docDisplayCompact": "Compact",
        "docDisplayImmersive": "Immersive",
        "instructionsBottom": "Instructions at bottom",
        "instructionsOnCamera": "Instructions on camera",
        "mrz": "MRZ (Machine Readable Zone)",
        "fields": "fields",
        "noExtractedData": "No extracted data",
        "none": "None",
        "result": "Result",
        "notDetected": "Not detected",
        "threshold": "Threshold",
        "selfieCapturedNoAnalysis": "Selfie captured successfully. No document analysis performed.",
        "errorDecodeImage": "Error: unable to decode image",
        "intro": "Intro",
        "instructions": "Instructions",
        "amlScreening": "AML / Sanctions Screening",
        "amlStatus": "Status",
        "amlRiskLevel": "Risk Level",
        "amlMatches": "Matches",
        "amlClear": "No matches found",
        "amlMatch": "Match found",
        "amlError": "Screening error",
        "amlDisabled": "Disabled",
    ],
    "wo": [
        "appTitle": "KyvShield Demo",
        "captureSteps": "Etapes yi",
        "selfie": "Selfie",
        "selfieDesc": "Nataal kanam",
        "recto": "Kanam",
        "rectoDesc": "Kanam kaart bi",
        "verso": "Ginnaaw",
        "versoDesc": "Ginnaaw kaart bi",
        "flowOptions": "Tànneef yi",
        "introPage": "Xëtu njëkk",
        "introPageDesc": "Wone xëtu njëkk bi",
        "instructionPages": "Xëtu ndimbal",
        "instructionPagesDesc": "Wone ndigal yi balaa etap bu nekk",
        "resultPage": "Xëtu gisaat",
        "resultPageDesc": "Wone jeexital bi",
        "successPerStep": "Yëgge etap",
        "successPerStepDesc": "Wone yëgge bu baax",
        "faceMatch": "Seetu kanam",
        "faceMatchDesc": "Seetante selfie ak nataal kaart bi",
        "challengeAudio": "Audio jëf yi",
        "challengeAudioDesc": "Déglu ndigal audio yi",
        "language": "Làkk",
        "securityLevel": "Tolluwaayu kaarange",
        "displayMode": "Anamu wone",
        "selfieDisplay": "Anamu selfie",
        "documentDisplay": "Anamu kaart",
        "document": "Kaart",
        "allCountries": "Réew yépp",
        "autoDetect": "Seet ci boppam",
        "autoDetectDesc": "Claude dina seet xeeti kaart bi ci boppam",
        "apiOptions": "Tànneef API",
        "apiUrl": "URL API",
        "apiKey": "Caabi API",
        "kycIdentifier": "Tànneefug KYC",
        "kycIdentifierHint": "Wakhtaanul: sa référence",
        "theme": "Anamu",
        "themeMode": "Anamu",
        "light": "Leer",
        "dark": "Lëndëm",
        "auto": "Auto",
        "startVerification": "Tambali seet bi",
        "configSummary": "Jeexital tànneef yi",
        "noStepSelected": "Amul etap bu tànnees",
        "lastResult": "Njeexital bi mujj",
        "success": "Baax na",
        "failed": "Baxtul",
        "resultDetails": "Xam-xam ci njeexital bi",
        "noResult": "Amul njeexital",
        "loading": "Di yegge...",
        "error": "Njumte",
        "selectAtLeastOneStep": "Tànnal benn etap bu mag",
        "documentType": "Xeeti kaart",
        "noDocumentAvailable": "Amul kaart bu am",
        "selectDocument": "Tànnal benn kaart",
        "rectoVerso": "Kanam + Ginnaaw",
        "rectoOnly": "Kanam rekk",
        "rectoOnlySupported": "kanam rekk la mën",
        "captureOptions": "Tànneef nataal",
        "display": "Woneg",
        "selectAtLeastOneStepAbove": "Tànnal benn etap ci kaw",
        "flowOptionsSection": "Tànneef yi",
        "configuredFlow": "Flux bi ci:",
        "noStepConfigured": "Amul etap bu am",
        "starting": "Tambali...",
        "custom": "Custom",
        "customColor": "Melo bu ëpp",
        "cancel": "Neenal",
        "apply": "Jëfandikoo",
        "themeInnolink": "Innolink",
        "themeBlue": "Baxa",
        "themeGreen": "Wert",
        "themePurple": "Violet",
        "themeKratos": "Kratos",
        "themeLuna": "Luna",
        "verificationCompleteSuccess": "Seet bi baax na yépp",
        "verificationFailed": "Seet bi baxtul",
        "documentsVerified": "Kaart yi seetees nañu",
        "documentVerificationFailed": "Seet kaart yi baxtul",
        "rectoFaceVerified": "Kanam + Kanam seetees nañu",
        "rectoVerified": "Kanam bi seetees na",
        "rectoVerificationFailed": "Seet kanam bi baxtul",
        "versoVerified": "Ginnaaw bi seetees na",
        "versoVerificationFailed": "Seet ginnaaw bi baxtul",
        "selfieCaptured": "Selfie nataaloo na",
        "selfieFailed": "Selfie baxtul",
        "completed": "Jeex na",
        "cancelled": "Dindi nañu",
        "authenticityScore": "Notu dëgg",
        "scannedDocuments": "Kaart yi seetees nañu",
        "extractedPhotos": "Nataal yi ci kaart bi",
        "extractedPhoto": "Nataal bu àgg",
        "humanFace": "Kanam nit",
        "faceMatchResult": "Kanam yi mën nañu",
        "faceNoMatchResult": "Kanam yi mënuñu",
        "componentScores": "Not yi",
        "overallScore": "Not bu mag",
        "liveness": "Dund",
        "processingTime": "Waxtu jëf bi",
        "total": "Yépp",
        "imageSavedToGallery": "Nataal bi denc nañu ko ci galerie",
        "cameraRequired": "Kaméra waral na",
        "cameraAccessDenied": "Kaméra bi tëj nañu la. Ubbil ko ci tànneef appareil bi.",
        "openSettings": "Ubbi tànneef yi",
        "selfieDisplayStandard": "Standard",
        "selfieDisplayCompact": "Compact",
        "selfieDisplayImmersive": "Immersif",
        "challengeBottom": "Challenge ci suuf",
        "challengeOnCamera": "Challenge ci kaméra",
        "fullScreen": "Ecran bu mat",
        "docDisplayStandard": "Standard",
        "docDisplayCompact": "Compact",
        "docDisplayImmersive": "Immersif",
        "instructionsBottom": "Ndigal ci suuf",
        "instructionsOnCamera": "Ndigal ci kaméra",
        "mrz": "MRZ (Machine Readable Zone)",
        "fields": "tomb",
        "noExtractedData": "Amul njoxe",
        "none": "Amul",
        "result": "Njeexital",
        "notDetected": "Gisul ko",
        "threshold": "Palier",
        "selfieCapturedNoAnalysis": "Selfie nataaloo na. Amul seet kaart bu amees.",
        "errorDecodeImage": "Njumte: mënu ko decode nataal bi",
        "intro": "Intro",
        "instructions": "Ndigal",
        "amlScreening": "Seet AML / Sanctions",
        "amlStatus": "Wàllu",
        "amlRiskLevel": "Tolluwaayu riskk",
        "amlMatches": "Seetante",
        "amlClear": "Amul seetante",
        "amlMatch": "Am na seetante",
        "amlError": "Njumte ci seet bi",
        "amlDisabled": "Tëj nañu ko",
    ],
]

// MARK: - Design Tokens

private struct DS {
    // spacing
    static let page:    CGFloat = 24
    static let card:    CGFloat = 20
    static let section: CGFloat = 24
    static let item:    CGFloat = 8

    // radius
    static let cardR:   CGFloat = 16
    static let btnR:    CGFloat = 12
    static let inputR:  CGFloat = 12
    static let chipR:   CGFloat = 12
    static let pillR:   CGFloat = 20
    static let smallR:  CGFloat = 8
    static let tinyR:   CGFloat = 4
}

// MARK: - ContentView

struct ContentView: View {

    // ─── State ──────────────────────────────────────────────────────────────

    // Brightness / dark mode
    @State private var appBrightness: AppBrightness = .light
    @Environment(\.colorScheme) private var systemColorScheme

    private var isDark: Bool {
        switch appBrightness {
        case .light: return false
        case .dark:  return true
        case .auto:  return systemColorScheme == .dark
        }
    }

    // Theme
    @State private var selectedTheme: AppTheme = .default
    @State private var customColor: Color = Color(hex: "EF8352")

    private var primaryColor: Color {
        selectedTheme == .custom ? customColor : selectedTheme.color
    }

    // Capture steps
    @State private var captureSelfie = false
    @State private var captureRecto  = false
    @State private var captureVerso  = false

    // Challenge modes per step
    @State private var selfieChallengeMode: ChallengeMode = .minimal
    @State private var rectoChallengeMode:  ChallengeMode = .minimal
    @State private var versoChallengeMode:  ChallengeMode = .minimal

    // Display modes
    @State private var selfieDisplayMode:   SelfieDisplayMode   = .standard
    @State private var documentDisplayMode: DocumentDisplayMode  = .standard

    // Flow options
    @State private var showIntroPage        = false
    @State private var showInstructionPages = true
    @State private var showResultPage       = false
    @State private var showSuccessPerStep   = true
    @State private var requireFaceMatch     = false
    @State private var playChallengeAudio   = true

    // API options
    @State private var kycIdentifier = ""

    // Language
    @State private var selectedLanguage = "fr"

    // Documents
    @State private var documentTypes:     [KyvshieldDocument] = []
    @State private var selectedDocument:  KyvshieldDocument?  = nil
    @State private var selectedCountry:   String?             = nil
    @State private var isLoadingDocuments = true

    // KYC flow
    @State private var isLoading    = false
    @State private var showKycView  = false
    @State private var lastResult:  KYCResult? = nil

    // Image popup
    @State private var popupImage:   Data?   = nil
    @State private var popupTitle:   String  = ""
    @State private var showImagePopup = false

    // Custom color picker
    @State private var showColorPicker = false
    @State private var tempCustomColor: Color = Color(hex: "EF8352")

    // Camera denied dialog
    @State private var showCameraPermissionAlert = false

    // Snackbar / toast
    @State private var toastMessage:  String = ""
    @State private var toastIsError:  Bool   = false
    @State private var showToast:     Bool   = false

    // BUG 6 fix: entry animation trigger — flips to true on first appear
    @State private var didAppear: Bool = false
    // BUG 6 fix: result card animation trigger — flips to true when a result arrives
    @State private var didShowResult: Bool = false

    // ─── Localisation helper ─────────────────────────────────────────────────

    private func t(_ key: String) -> String {
        exampleStrings[selectedLanguage]?[key]
        ?? exampleStrings["fr"]?[key]
        ?? key
    }

    // ─── Design tokens (brightness-aware) ───────────────────────────────────

    private var bgColor:       Color { isDark ? Color(hex: "0F172A") : Color(hex: "F9FAFB") }
    private var cardColor:     Color { isDark ? Color(hex: "1E293B") : .white }
    private var textPrimary:   Color { isDark ? .white               : Color(hex: "111827") }
    private var textSecondary: Color { isDark ? Color(hex: "CBD5E1") : Color(hex: "4B5563") }
    private var textTertiary:  Color { isDark ? Color(hex: "94A3B8") : Color(hex: "6B7280") }
    private var borderColor:   Color { isDark ? Color(hex: "334155") : Color(hex: "E5E7EB") }
    private var inputBg:       Color { isDark ? Color(hex: "1E293B") : Color(hex: "F9FAFB") }
    private var inputBorder:   Color { isDark ? Color(hex: "334155") : Color(hex: "D1D5DB") }
    private var chipBg:        Color { isDark ? Color(hex: "334155") : Color(hex: "F3F4F6") }
    private var chipText:      Color { isDark ? Color(hex: "CBD5E1") : Color(hex: "374151") }

    // ─── Filtered documents ──────────────────────────────────────────────────

    private var filteredDocuments: [KyvshieldDocument] {
        guard let country = selectedCountry else { return documentTypes }
        return documentTypes.filter { $0.country == country }
    }

    private var availableCountries: [(code: String, name: String)] {
        var seen = Set<String>()
        var result: [(code: String, name: String)] = []
        for doc in documentTypes {
            if seen.insert(doc.country).inserted {
                let label = doc.countryName.isEmpty ? doc.country : doc.countryName
                result.append((code: doc.country, name: label))
            }
        }
        return result
    }

    // ─── Body ────────────────────────────────────────────────────────────────

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            RefreshableScrollContent {
                await loadDocuments()
            } content: {
                VStack(spacing: 0) {
                    headerSection
                        .padding(.bottom, 32)
                        .opacity(didAppear ? 1 : 0)
                        .offset(y: didAppear ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(0.1), value: didAppear)

                    configCard
                        .padding(.bottom, DS.section)
                        .opacity(didAppear ? 1 : 0)
                        .offset(y: didAppear ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(0.2), value: didAppear)

                    actionButtons
                        .padding(.bottom, DS.section)
                        .opacity(didAppear ? 1 : 0)
                        .offset(y: didAppear ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(0.3), value: didAppear)

                    if let result = lastResult {
                        resultSection(result: result)
                            .padding(.bottom, DS.section)
                            .opacity(didAppear ? 1 : 0)
                            .offset(y: didAppear ? 0 : 20)
                            .animation(.easeOut(duration: 0.4).delay(0.4), value: didAppear)
                    }
                }
                .padding(DS.page)
            }
            .background(bgColor)

            // Toast overlay
            if showToast {
                VStack {
                    Spacer()
                    HStack(spacing: 10) {
                        Image(systemName: toastIsError ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
                            .foregroundColor(.white)
                        Text(toastMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(toastIsError ? Color.red : Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, DS.page)
                    .padding(.bottom, 32)
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: showToast)
            }
        }
        .preferredColorScheme(appBrightness == .auto ? nil : (isDark ? .dark : .light))
        .onAppear {
            fetchDocuments()
            // BUG 6: trigger entry animations after first layout pass
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation { didAppear = true }
            }
        }
        // Image popup
        .fullScreenCover(isPresented: $showImagePopup) {
            if let data = popupImage {
                ImagePopupView(
                    imageData:   data,
                    title:       popupTitle,
                    chipText:    chipText,
                    textPrimary: textPrimary
                ) {
                    showImagePopup = false
                } onSave: {
                    saveImageToGallery(data: data, title: popupTitle)
                }
            }
        }
        // KYC flow (KyvshieldView presented full-screen)
        .fullScreenCover(isPresented: $showKycView) {
            if let cfg = pendingConfig, let flow = pendingFlow {
                KyvshieldView(config: cfg, flow: flow) { result in
                    print("[KYC] Result received: success=\(result.success), status=\(result.overallStatus)")
                    print("[KYC] selfie=\(result.selfieResult != nil), recto=\(result.rectoResult != nil), verso=\(result.versoResult != nil)")
                    print("[KYC] sessionId=\(result.sessionId ?? "nil"), error=\(result.errorMessage ?? "nil")")
                    if let recto = result.rectoResult {
                        print("[KYC] recto.score=\(recto.score), fields=\(recto.extraction?.fields.count ?? 0)")
                    }
                    showKycView    = false
                    didShowResult  = false
                    lastResult     = result
                    // BUG 6: trigger staggered result card entry animations
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation { didShowResult = true }
                    }
                }
            }
        }
        // Camera denied alert
        .alert(t("cameraRequired"), isPresented: $showCameraPermissionAlert) {
            Button(t("cancel"), role: .cancel) {}
            Button(t("openSettings")) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
        } message: {
            Text(t("cameraAccessDenied"))
        }
        // Custom color picker sheet
        .sheet(isPresented: $showColorPicker) {
            colorPickerSheet
        }
    }

    // MARK: - Fetch documents

    private func fetchDocuments() {
        isLoadingDocuments = true
        NetworkHelper.fetchDocuments { result in
            switch result {
            case .success(let docs):
                self.documentTypes = docs
                if self.selectedDocument != nil {
                    let match = docs.first(where: { $0.docType == self.selectedDocument!.docType })
                    self.selectedDocument = match ?? docs.first
                } else {
                    self.selectedDocument = docs.first
                }
            case .failure:
                break
            }
            self.isLoadingDocuments = false
        }
    }

    @MainActor
    private func loadDocuments() async {
        await withCheckedContinuation { continuation in
            NetworkHelper.fetchDocuments { result in
                switch result {
                case .success(let docs):
                    self.documentTypes = docs
                    if self.selectedDocument != nil {
                        let match = docs.first(where: { $0.docType == self.selectedDocument!.docType })
                        self.selectedDocument = match ?? docs.first
                    } else {
                        self.selectedDocument = docs.first
                    }
                case .failure:
                    break
                }
                self.isLoadingDocuments = false
                continuation.resume()
            }
        }
    }

    // MARK: - Start KYC (stub — wire up KyvshieldLite)

    private func startKYC() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .denied || status == .restricted {
            showCameraPermissionAlert = true
            return
        }
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted { self.launchKYC() }
                    else       { self.showCameraPermissionAlert = true }
                }
            }
            return
        }
        launchKYC()
    }

    private func launchKYC() {
        guard captureSelfie || captureRecto || captureVerso else {
            showError(t("selectAtLeastOneStep"))
            return
        }
        isLoading = true

        // ── SDK config ───────────────────────────────────────────────────────
        let sdkConfig = KyvshieldConfig(
            baseUrl:   NetworkHelper.apiBaseURL,
            apiKey:    NetworkHelper.apiKey,
            theme: KyvshieldThemeConfig(
                primaryColor: UIColor(primaryColor),
                brightness:   isDark ? .dark : .light
            ),
            enableLog: true
        )

        // ── Build steps ──────────────────────────────────────────────────────
        var steps: [CaptureStep] = []
        if captureSelfie { steps.append(.selfie) }
        if captureRecto  { steps.append(.recto)  }
        if captureVerso  { steps.append(.verso)  }

        // ── Build per-step challenge modes ───────────────────────────────────
        var scm: [CaptureStep: ChallengeMode] = [:]
        if captureSelfie { scm[.selfie] = selfieChallengeMode }
        if captureRecto  { scm[.recto]  = rectoChallengeMode  }
        if captureVerso  { scm[.verso]  = versoChallengeMode  }

        // ── Build flow config ────────────────────────────────────────────────
        let sdkFlow = KyvshieldFlowConfig(
            steps:               steps,
            target:              selectedDocument,
            kycIdentifier:       kycIdentifier.isEmpty ? nil : kycIdentifier,
            challengeMode:       .minimal,              // global default; per-step overrides in scm
            stepChallengeModes:  scm,
            selfieDisplayMode:   selfieDisplayMode,
            documentDisplayMode: documentDisplayMode,
            requireFaceMatch:    requireFaceMatch,
            showIntroPage:       showIntroPage,
            showInstructionPages: showInstructionPages,
            showResultPage:      showResultPage,
            showSuccessPerStep:  showSuccessPerStep,
            language:            selectedLanguage,
            playChallengeAudio:  playChallengeAudio
        )

        // ── Present the SDK flow (SwiftUI fullScreenCover) ───────────────────
        // We drive presentation via showKycView; the fullScreenCover is wired
        // in the body via the stored sdkConfig/sdkFlow below.  We store them
        // as @State so the cover can access them.
        pendingConfig = sdkConfig
        pendingFlow   = sdkFlow
        isLoading     = false
        showKycView   = true
    }

    // Stored SDK config/flow, set just before showKycView = true
    @State private var pendingConfig: KyvshieldConfig? = nil
    @State private var pendingFlow:   KyvshieldFlowConfig? = nil

    // MARK: - Health check

    private func healthCheck() {
        NetworkHelper.healthCheck { status in
            self.showSuccess("Health: \(status)")
        }
    }

    // MARK: - Validate key

    private func validateKey() {
        NetworkHelper.validateKey { ok, message in
            if ok { self.showSuccess("API Key valid: \(message)") }
            else  { self.showError("Invalid key: \(message)")     }
        }
    }

    // MARK: - Toast helpers

    private func showSuccess(_ msg: String) {
        toastMessage = msg; toastIsError = false; fireToast()
    }
    private func showError(_ msg: String) {
        toastMessage = msg; toastIsError = true; fireToast()
    }
    private func fireToast() {
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation { self.showToast = false }
        }
    }

    // MARK: - Flow summary

    private func buildFlowSummary() -> String {
        let docCode = selectedDocument?.docType ?? t("none")
        var steps: [String] = ["[\(docCode)]"]
        if showIntroPage { steps.append(t("intro")) }
        if captureSelfie {
            if showInstructionPages { steps.append("\(t("instructions")) Selfie") }
            steps.append("Selfie[\(selfieChallengeMode.rawValue)]")
        }
        if captureRecto {
            if showInstructionPages { steps.append("\(t("instructions")) \(t("recto"))") }
            steps.append("\(t("recto"))[\(rectoChallengeMode.rawValue)]")
        }
        if captureVerso {
            if showInstructionPages { steps.append("\(t("instructions")) \(t("verso"))") }
            steps.append("\(t("verso"))[\(versoChallengeMode.rawValue)]")
        }
        if showResultPage { steps.append(t("result")) }
        if steps.count <= 1 { return "[\(docCode)] - \(t("noStepConfigured"))" }
        return steps.joined(separator: " → ")
    }

    // MARK: - Challenge labels

    private func challengesForMode(stepType: String, mode: ChallengeMode) -> [String] {
        let isDoc = (stepType == "Recto" || stepType == "Verso")
        if isDoc {
            switch mode {
            case .minimal:  return ["center_document"]
            case .standard: return ["center_document", "tilt_left", "tilt_right"]
            case .strict:   return ["center_document", "tilt_left", "tilt_right", "tilt_forward", "tilt_back"]
            }
        } else {
            switch mode {
            case .minimal:  return ["center_face", "close_eyes"]
            case .standard: return ["center_face", "close_eyes", "turn_left", "turn_right"]
            case .strict:   return ["center_face", "close_eyes", "turn_left", "turn_right", "smile", "look_up", "look_down"]
            }
        }
    }

    private func challengeShortLabel(_ c: String) -> String {
        switch c {
        case "center_document": return "Center"
        case "tilt_left":       return "↙ Left"
        case "tilt_right":      return "↗ Right"
        case "tilt_forward":    return "↑ Fwd"
        case "tilt_back":       return "↓ Back"
        case "center_face":     return "Face"
        case "close_eyes":      return "Eyes"
        case "turn_left":       return "← Turn"
        case "turn_right":      return "→ Turn"
        case "smile":           return "Smile"
        case "look_up":         return "↑ Up"
        case "look_down":       return "↓ Down"
        default:                return c
        }
    }

    // MARK: - Result title

    private func getResultTitle(_ r: KYCResult) -> String {
        let hasRecto = r.rectoImage != nil
        let hasVerso = r.versoImage != nil
        let hasSelfie = r.selfieImage != nil
        let fv = r.faceResult
        if hasRecto && hasVerso && fv != nil {
            return (r.rectoAuthenticityScore ?? 0) > 0 && (r.versoAuthenticityScore ?? 0) > 0
                ? t("verificationCompleteSuccess") : t("verificationFailed")
        } else if hasRecto && hasVerso {
            return t("documentsVerified")
        } else if hasRecto && fv != nil {
            return t("rectoFaceVerified")
        } else if hasRecto {
            return r.success ? t("rectoVerified") : t("rectoVerificationFailed")
        } else if hasVerso {
            return r.success ? t("versoVerified") : t("versoVerificationFailed")
        } else if hasSelfie {
            return r.success ? t("selfieCaptured") : t("selfieFailed")
        } else {
            return r.success ? t("completed") : t("cancelled")
        }
    }

    private func statusColor(for status: String) -> Color {
        switch status.uppercased() {
        case "PASS":   return primaryColor
        case "REVIEW": return .orange
        case "REJECT": return .red
        default:       return .gray
        }
    }

    // MARK: - Icon for field key

    private func iconForField(_ key: String) -> String {
        switch key {
        case "document_id", "document_number", "cin": return "creditcard"
        case "national_id", "nin":                    return "person.text.rectangle"
        case "last_name", "first_name", "first_names": return "person"
        case "birth_date", "date_of_birth", "issue_date", "expiry_date": return "calendar"
        case "birth_place", "place_of_birth", "birth_region", "address": return "mappin"
        case "profession":                             return "briefcase"
        case "nationality", "country_code":            return "globe"
        case "height":                                 return "ruler"
        case "issuing_authority", "electoral_status":  return "building.2"
        default:                                       return "doc.text"
        }
    }

    // MARK: - Save image to gallery

    private func saveImageToGallery(data: Data, title: String) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized || status == .limited else { return }
            guard let image = UIImage(data: data) else { return }
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { success, error in
                DispatchQueue.main.async {
                    if success { self.showSuccess(self.t("imageSavedToGallery")) }
                    else       { self.showError(error?.localizedDescription ?? "Error") }
                }
            }
        }
    }

    // =========================================================================
    // MARK: - Header
    // =========================================================================

    private var headerSection: some View {
        VStack(spacing: 16) {
            // Shield icon container
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(primaryColor.opacity(0.1))
                    .frame(width: 80, height: 80)
                Image(systemName: "shield.fill")
                    .font(.system(size: 40))
                    .foregroundColor(primaryColor)
            }

            Text("KyvShield SDK")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(textPrimary)

            Text("CIN Verification Demo")
                .font(.system(size: 16))
                .foregroundColor(textSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    // =========================================================================
    // MARK: - Config Card
    // =========================================================================

    private var configCard: AnyView { AnyView(_configCard) }
    private var _configCard: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Document type ────────────────────────────────────────────────
            sectionHeader(icon: "checkmark.circle", title: t("documentType")) {
                if isLoadingDocuments {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: primaryColor))
                        .scaleEffect(0.7)
                }
            }
            .padding(.bottom, 12)

            // Country filter chips
            if !availableCountries.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        countryChip(code: nil, label: t("allCountries"))
                        ForEach(availableCountries, id: \.code) { entry in
                            countryChip(code: entry.code, label: entry.name)
                        }
                    }
                }
                .padding(.bottom, 12)
            }

            // Document picker
            documentPickerView
                .padding(.bottom, 20)

            dividerLine

            // ── Capture steps ────────────────────────────────────────────────
            sectionHeader(icon: "camera", title: t("captureOptions"))
                .padding(.vertical, 16)

            HStack(spacing: 8) {
                toggleChip(label: t("selfie"), value: $captureSelfie,
                           icon: "person", enabled: true)
                toggleChip(label: t("recto"), value: $captureRecto,
                           icon: "creditcard",
                           enabled: selectedDocument?.hasRecto ?? true)
                toggleChip(label: t("verso"), value: $captureVerso,
                           icon: "rectangle.landscape.rotate",
                           enabled: selectedDocument?.hasVerso ?? true)
            }

            // Verso not supported hint
            if let doc = selectedDocument, !doc.hasVerso {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 14))
                        .foregroundColor(primaryColor)
                    Text("\(doc.name) \(t("rectoOnlySupported"))")
                        .font(.system(size: 11))
                        .foregroundColor(primaryColor)
                }
                .padding(8)
                .background(primaryColor.opacity(0.08))
                .cornerRadius(DS.smallR)
                .padding(.top, 8)
            }

            // ── Display mode ─────────────────────────────────────────────────
            if captureSelfie || captureRecto || captureVerso {
                Spacer().frame(height: 20)
                dividerLine

                sectionHeader(icon: "rectangle.split.2x1", title: t("display"))
                    .padding(.vertical, 16)

                if captureSelfie {
                    selfieDisplayModeRow
                        .padding(.bottom, 12)
                }
                if captureRecto || captureVerso {
                    documentDisplayModeRow
                        .padding(.bottom, 12)
                }
                Spacer().frame(height: 4)
                dividerLine
            } else {
                Spacer().frame(height: 20)
                dividerLine
            }

            // ── Security level ───────────────────────────────────────────────
            sectionHeader(icon: "checkmark.shield", title: t("securityLevel"))
                .padding(.vertical, 16)

            if captureSelfie {
                stepChallengeModeRow(
                    stepName: t("selfie"),
                    icon:     "person",
                    mode:     $selfieChallengeMode
                )
                .padding(.bottom, 8)
            }
            if captureRecto {
                stepChallengeModeRow(
                    stepName: t("recto"),
                    icon:     "creditcard",
                    mode:     $rectoChallengeMode
                )
                .padding(.bottom, 8)
            }
            if captureVerso {
                stepChallengeModeRow(
                    stepName: t("verso"),
                    icon:     "rectangle.landscape.rotate",
                    mode:     $versoChallengeMode
                )
            }
            if !captureSelfie && !captureRecto && !captureVerso {
                Text(t("selectAtLeastOneStepAbove"))
                    .font(.system(size: 13))
                    .italic()
                    .foregroundColor(textTertiary)
            }

            Spacer().frame(height: 20)
            dividerLine

            // ── Flow options ─────────────────────────────────────────────────
            sectionHeader(icon: "list.bullet.rectangle", title: t("flowOptionsSection"))
                .padding(.vertical, 16)

            switchTile(title:    t("introPage"),
                       subtitle: t("introPageDesc"),
                       icon:     "house",
                       value:    $showIntroPage)

            switchTile(title:    t("instructionPages"),
                       subtitle: t("instructionPagesDesc"),
                       icon:     "info.circle",
                       value:    $showInstructionPages)

            switchTile(title:    t("resultPage"),
                       subtitle: t("resultPageDesc"),
                       icon:     "checkmark.square",
                       value:    $showResultPage)

            switchTile(title:    t("successPerStep"),
                       subtitle: t("successPerStepDesc"),
                       icon:     "sparkles",
                       value:    $showSuccessPerStep)

            switchTile(title:    t("faceMatch"),
                       subtitle: t("faceMatchDesc"),
                       icon:     "faceid",
                       value:    $requireFaceMatch)

            switchTile(title:    t("challengeAudio"),
                       subtitle: t("challengeAudioDesc"),
                       icon:     "speaker.wave.2",
                       value:    $playChallengeAudio)

            Spacer().frame(height: 16)
            dividerLine

            // ── API options ──────────────────────────────────────────────────
            sectionHeader(icon: "server.rack", title: t("apiOptions"))
                .padding(.vertical, 16)

            // KYC Identifier input
            kycIdentifierInput
                .padding(.bottom, 20)

            dividerLine

            // ── Language ─────────────────────────────────────────────────────
            sectionHeader(icon: "globe", title: t("language"))
                .padding(.vertical, 16)

            languageChips
                .padding(.bottom, 20)

            dividerLine

            // ── Theme ────────────────────────────────────────────────────────
            sectionHeader(icon: "paintpalette", title: t("theme"))
                .padding(.vertical, 16)

            themeChips
                .padding(.bottom, 8)

            customThemeChip
                .padding(.bottom, 16)

            dividerLine

            // ── Brightness ───────────────────────────────────────────────────
            sectionHeader(icon: "sun.max", title: t("themeMode"))
                .padding(.vertical, 16)

            brightnessChips
                .padding(.bottom, 16)

            // ── Flow summary ─────────────────────────────────────────────────
            flowSummaryBox
        }
        .padding(DS.card)
        .background(cardColor)
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    // MARK: - Document picker

    private var documentPickerView: AnyView {
        AnyView(Group {
            if filteredDocuments.isEmpty {
                HStack {
                    Text(isLoadingDocuments ? t("loading") : t("noDocumentAvailable"))
                        .font(.system(size: 14))
                        .foregroundColor(textTertiary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(inputBg)
                .cornerRadius(DS.inputR)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.inputR)
                        .stroke(inputBorder, lineWidth: 1)
                )
            } else {
                Menu {
                    ForEach(filteredDocuments, id: \.docType) { doc in
                        Button {
                            selectedDocument = doc
                            if !doc.hasVerso { versoChallengeMode = .minimal }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(doc.docType)
                                Text(doc.name)
                            }
                        }
                    }
                } label: {
                    HStack {
                        if let doc = selectedDocument, filteredDocuments.contains(where: { $0.docType == doc.docType }) {
                            HStack(spacing: 10) {
                                Text(doc.docType)
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(primaryColor)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(primaryColor.opacity(0.1))
                                    .cornerRadius(6)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(doc.name)
                                        .font(.system(size: 13))
                                        .foregroundColor(chipText)
                                        .lineLimit(1)
                                    Text(doc.hasVerso ? t("rectoVerso") : t("rectoOnly"))
                                        .font(.system(size: 10))
                                        .foregroundColor(textTertiary)
                                }
                            }
                        } else {
                            Text(t("selectDocument"))
                                .font(.system(size: 14))
                                .foregroundColor(textTertiary)
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(primaryColor)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(inputBg)
                    .cornerRadius(DS.inputR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.inputR)
                            .stroke(inputBorder, lineWidth: 1)
                    )
                }
            }
        })
    }

    // MARK: - Country chip

    private func countryChip(code: String?, label: String) -> some View {
        let isSelected = selectedCountry == code
        return Button {
            selectedCountry = code
            if let code = code,
               let doc = selectedDocument,
               doc.country != code {
                selectedDocument = filteredDocuments.first
            }
        } label: {
            Text(label)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : chipText)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? primaryColor : chipBg)
                .cornerRadius(DS.pillR)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.pillR)
                        .stroke(isSelected ? primaryColor : borderColor, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }

    // MARK: - Toggle chip (Selfie / Recto / Verso)

    private func toggleChip(label: String,
                             value: Binding<Bool>,
                             icon: String,
                             enabled: Bool) -> some View {
        let isDisabled = !enabled
        let effective  = enabled && value.wrappedValue
        return Button {
            if enabled { value.wrappedValue.toggle() }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isDisabled ? textTertiary : (effective ? primaryColor : textTertiary))
                Text(label)
                    .font(.system(size: 12, weight: effective ? .semibold : .medium))
                    .foregroundColor(isDisabled ? textTertiary : (effective ? primaryColor : chipText))
                if isDisabled {
                    Text("N/A")
                        .font(.system(size: 8))
                        .foregroundColor(textTertiary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(isDisabled ? chipBg : (effective ? primaryColor.opacity(0.1) : chipBg))
            .cornerRadius(DS.chipR)
            .overlay(
                RoundedRectangle(cornerRadius: DS.chipR)
                    .stroke(
                        isDisabled ? borderColor : (effective ? primaryColor : borderColor),
                        lineWidth: effective ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: value.wrappedValue)
    }

    // MARK: - Selfie / Document display mode rows

    private var selfieDisplayModeRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "rectangle.split.2x1")
                    .font(.system(size: 16))
                    .foregroundColor(primaryColor)
                Text(t("selfieDisplay"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(chipText)
            }
            HStack(spacing: 6) {
                displayModeChip(label: t("selfieDisplayStandard"), desc: t("challengeBottom"),
                                icon: "rectangle.split.2x1.fill",
                                isSelected: selfieDisplayMode == .standard) {
                    selfieDisplayMode = .standard
                }
                displayModeChip(label: t("selfieDisplayCompact"), desc: t("challengeOnCamera"),
                                icon: "rectangle.split.1x2.fill",
                                isSelected: selfieDisplayMode == .compact) {
                    selfieDisplayMode = .compact
                }
                displayModeChip(label: t("selfieDisplayImmersive"), desc: t("fullScreen"),
                                icon: "arrow.up.left.and.arrow.down.right",
                                isSelected: selfieDisplayMode == .immersive) {
                    selfieDisplayMode = .immersive
                }
                displayModeChip(label: "Neon HUD", desc: "Futuriste",
                                icon: "desktopcomputer",
                                isSelected: selfieDisplayMode == .neonHud) {
                    selfieDisplayMode = .neonHud
                }
            }
        }
        .padding(12)
        .background(primaryColor.opacity(0.05))
        .cornerRadius(DS.chipR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.chipR)
                .stroke(primaryColor.opacity(0.2), lineWidth: 1)
        )
    }

    private var documentDisplayModeRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "creditcard")
                    .font(.system(size: 16))
                    .foregroundColor(primaryColor)
                Text(t("documentDisplay"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(chipText)
            }
            HStack(spacing: 6) {
                displayModeChip(label: t("docDisplayStandard"), desc: t("instructionsBottom"),
                                icon: "rectangle.split.2x1.fill",
                                isSelected: documentDisplayMode == .standard) {
                    documentDisplayMode = .standard
                }
                displayModeChip(label: t("docDisplayCompact"), desc: t("instructionsOnCamera"),
                                icon: "rectangle.split.1x2.fill",
                                isSelected: documentDisplayMode == .compact) {
                    documentDisplayMode = .compact
                }
                displayModeChip(label: t("docDisplayImmersive"), desc: t("fullScreen"),
                                icon: "arrow.up.left.and.arrow.down.right",
                                isSelected: documentDisplayMode == .immersive) {
                    documentDisplayMode = .immersive
                }
                displayModeChip(label: "Neon HUD", desc: "Futuriste",
                                icon: "desktopcomputer",
                                isSelected: documentDisplayMode == .neonHud) {
                    documentDisplayMode = .neonHud
                }
            }
        }
        .padding(12)
        .background(primaryColor.opacity(0.05))
        .cornerRadius(DS.chipR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.chipR)
                .stroke(primaryColor.opacity(0.2), lineWidth: 1)
        )
    }

    private func displayModeChip(label: String, desc: String, icon: String,
                                  isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? primaryColor : textTertiary)
                Text(label)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? primaryColor : chipText)
                Text(desc)
                    .font(.system(size: 8))
                    .foregroundColor(isSelected ? primaryColor.opacity(0.7) : textTertiary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 6)
            .background(isSelected ? primaryColor.opacity(0.1) : cardColor)
            .cornerRadius(DS.smallR)
            .overlay(
                RoundedRectangle(cornerRadius: DS.smallR)
                    .stroke(isSelected ? primaryColor : borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }

    // MARK: - Step challenge mode row

    private func stepChallengeModeRow(stepName: String,
                                      icon: String,
                                      mode: Binding<ChallengeMode>) -> some View {
        let challenges = challengesForMode(stepType: stepName, mode: mode.wrappedValue)
        return VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(primaryColor)
                Text(stepName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(chipText)
            }
            HStack(spacing: 6) {
                challengeModeChip(label: "Min",    mode: .minimal,  current: mode)
                challengeModeChip(label: "Std",    mode: .standard, current: mode)
                challengeModeChip(label: "Strict", mode: .strict,   current: mode)
            }
            // Challenge labels
            FlowLayout(spacing: 4) {
                ForEach(challenges, id: \.self) { c in
                    Text(challengeShortLabel(c))
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(primaryColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(primaryColor.opacity(0.1))
                        .cornerRadius(DS.tinyR)
                }
            }
        }
        .padding(12)
        .background(inputBg)
        .cornerRadius(DS.chipR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.chipR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    private func challengeModeChip(label: String,
                                   mode:  ChallengeMode,
                                   current: Binding<ChallengeMode>) -> some View {
        let isSelected = current.wrappedValue == mode
        return Button { current.wrappedValue = mode } label: {
            Text(label)
                .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? primaryColor : chipText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 6)
                .background(isSelected ? primaryColor.opacity(0.1) : cardColor)
                .cornerRadius(DS.smallR)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.smallR)
                        .stroke(isSelected ? primaryColor : borderColor, lineWidth: isSelected ? 2 : 1)
                )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }

    // MARK: - Switch tile

    private func switchTile(title: String, subtitle: String, icon: String,
                             value: Binding<Bool>) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(textTertiary)
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(textPrimary)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(textTertiary)
            }
            Spacer()
            Toggle("", isOn: value)
                .labelsHidden()
                .tint(primaryColor)
        }
        .padding(.bottom, 12)
    }

    // MARK: - KYC identifier input

    private var kycIdentifierInput: some View {
        HStack(spacing: 0) {
            Image(systemName: "tag")
                .font(.system(size: 18))
                .foregroundColor(textTertiary)
                .padding(.leading, 16)
                .padding(.trailing, 8)
            TextField("", text: $kycIdentifier, prompt:
                Text(t("kycIdentifierHint"))
                    .foregroundColor(textTertiary)
            )
            .font(.system(size: 14))
            .foregroundColor(textPrimary)
            .padding(.vertical, 12)
            .padding(.trailing, 16)
        }
        .background(inputBg)
        .cornerRadius(DS.inputR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.inputR)
                .stroke(inputBorder, lineWidth: 1)
        )
    }

    // MARK: - Language chips

    private let languages: [(code: String, name: String)] = [
        (code: "fr", name: "Français"),
        (code: "en", name: "English"),
        (code: "wo", name: "Wolof"),
    ]

    private var languageChips: some View {
        HStack(spacing: 8) {
            ForEach(languages, id: \.code) { lang in
                let isSelected = selectedLanguage == lang.code
                Button { selectedLanguage = lang.code } label: {
                    VStack(spacing: 2) {
                        Text(lang.code.uppercased())
                            .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                            .foregroundColor(isSelected ? primaryColor : chipText)
                        Text(lang.name)
                            .font(.system(size: 10))
                            .foregroundColor(isSelected ? primaryColor : textTertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(isSelected ? primaryColor.opacity(0.1) : chipBg)
                    .cornerRadius(DS.chipR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.chipR)
                            .stroke(isSelected ? primaryColor : borderColor, lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
        }
    }

    // MARK: - Theme chips

    private let namedThemes: [(theme: AppTheme, key: String)] = [
        (.default, "themeInnolink"),
        (.blue,    "themeBlue"),
        (.green,   "themeGreen"),
        (.purple,  "themePurple"),
        (.kratos,  "themeKratos"),
        (.luna,    "themeLuna"),
    ]

    private var themeChips: some View {
        FlowLayout(spacing: 8) {
            ForEach(namedThemes, id: \.theme.rawValue) { entry in
                let isSelected = selectedTheme == entry.theme
                let color      = entry.theme.color
                Button { selectedTheme = entry.theme } label: {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(color)
                            .frame(width: 16, height: 16)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(color: color.opacity(0.4), radius: 4)
                        Text(t(entry.key))
                            .font(.system(size: 12, weight: isSelected ? .semibold : .medium))
                            .foregroundColor(isSelected ? color : chipText)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isSelected ? color.opacity(0.15) : chipBg)
                    .cornerRadius(DS.pillR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.pillR)
                            .stroke(isSelected ? color : borderColor, lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
        }
    }

    private var customThemeChip: some View {
        let isSelected = selectedTheme == .custom
        let color      = customColor
        return Button { showColorPicker = true } label: {
            HStack(spacing: 6) {
                // Rainbow circle
                Circle()
                    .fill(
                        AngularGradient(
                            colors: [.red, .orange, .yellow, .green, .blue, .purple, .red],
                            center: .center
                        )
                    )
                    .frame(width: 16, height: 16)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text(t("custom"))
                    .font(.system(size: 12, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? color : chipText)

                if isSelected {
                    Circle()
                        .fill(color)
                        .frame(width: 12, height: 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? color.opacity(0.15) : chipBg)
            .cornerRadius(DS.pillR)
            .overlay(
                RoundedRectangle(cornerRadius: DS.pillR)
                    .stroke(isSelected ? color : borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }

    // MARK: - Brightness chips

    private var brightnessChips: some View {
        HStack(spacing: 8) {
            brightnessChip(label: t("light"), icon: "sun.max",  mode: .light)
            brightnessChip(label: t("dark"),  icon: "moon",     mode: .dark)
            brightnessChip(label: t("auto"),  icon: "desktopcomputer", mode: .auto)
        }
    }

    private func brightnessChip(label: String, icon: String, mode: AppBrightness) -> some View {
        let isSelected = appBrightness == mode
        return Button { appBrightness = mode } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? primaryColor : textTertiary)
                Text(label)
                    .font(.system(size: 12, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? primaryColor : chipText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? primaryColor.opacity(0.1) : chipBg)
            .cornerRadius(DS.chipR)
            .overlay(
                RoundedRectangle(cornerRadius: DS.chipR)
                    .stroke(isSelected ? primaryColor : borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }

    // MARK: - Flow summary box

    private var flowSummaryBox: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(t("configuredFlow"))
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(primaryColor)
            Text(buildFlowSummary())
                .font(.system(size: 13))
                .foregroundColor(chipText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(primaryColor.opacity(0.05))
        .cornerRadius(DS.btnR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.btnR)
                .stroke(primaryColor.opacity(0.2), lineWidth: 1)
        )
    }

    // MARK: - Section header helper

    private func sectionHeader<Trailing: View>(icon: String,
                                               title: String,
                                               @ViewBuilder trailing: () -> Trailing) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(primaryColor)
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(textPrimary)
            Spacer()
            trailing()
        }
    }

    private func sectionHeader(icon: String, title: String) -> some View {
        sectionHeader(icon: icon, title: title, trailing: { EmptyView() })
    }

    private var dividerLine: some View {
        Divider()
            .background(borderColor)
    }

    // =========================================================================
    // MARK: - Action buttons
    // =========================================================================

    private var actionButtons: some View {
        VStack(spacing: 12) {
            // Primary: Start KYC
            Button {
                startKYC()
            } label: {
                HStack(spacing: 10) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 20, height: 20)
                    } else {
                        Image(systemName: "viewfinder")
                            .font(.system(size: 20))
                    }
                    Text(isLoading ? t("starting") : t("startVerification"))
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(isLoading ? primaryColor.opacity(0.7) : primaryColor)
                .cornerRadius(DS.cardR)
            }
            .disabled(isLoading)
            .animation(.easeInOut(duration: 0.2), value: isLoading)

            // Secondary: Health Check + Validate Key
            HStack(spacing: 12) {
                Button { healthCheck() } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "heart.circle")
                            .font(.system(size: 16))
                        Text("Health Check")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .cornerRadius(DS.btnR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.btnR)
                            .stroke(borderColor, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)

                Button { validateKey() } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "key")
                            .font(.system(size: 16))
                        Text("Validate Key")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .cornerRadius(DS.btnR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.btnR)
                            .stroke(borderColor, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    // =========================================================================
    // MARK: - Result section
    // =========================================================================

    @ViewBuilder
    private func resultSection(result: KYCResult) -> some View {
        let isSuccess    = result.success
        let statusColor  = isSuccess ? primaryColor : Color.red
        let statusIcon   = isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill"
        let hasRecto     = result.rectoImage != nil
        let hasVerso     = result.versoImage != nil
        let hasSelfie    = result.selfieImage != nil
        let hasDocAnalysis = hasRecto || hasVerso

        VStack(spacing: 16) {

            // ── Main status card ─────────────────────────────────────────────
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: statusIcon)
                        .font(.system(size: 24))
                        .foregroundColor(statusColor)
                    Text(getResultTitle(result))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(statusColor)
                    Spacer()
                    if hasDocAnalysis {
                        Text(result.overallStatus.label.uppercased())
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(self.statusColor(for: result.overallStatus.label))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(self.statusColor(for: result.overallStatus.label).opacity(0.1))
                            .cornerRadius(DS.pillR)
                    }
                }
                .padding(.bottom, 8)

                // Session ID
                HStack(spacing: 4) {
                    Image(systemName: "number")
                        .font(.system(size: 12))
                        .foregroundColor(textTertiary)
                    Text("Session: \(result.sessionId ?? "N/A")")
                        .font(.system(size: 11).monospaced())
                        .foregroundColor(textSecondary)
                        .lineLimit(1)
                    Spacer()
                    if let sid = result.sessionId {
                        Button {
                            UIPasteboard.general.string = sid
                            showSuccess("Session ID: \(sid)")
                        } label: {
                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 14))
                                .foregroundColor(textTertiary)
                        }
                        .buttonStyle(.plain)
                    }
                }

                // Authenticity score circle
                if hasDocAnalysis {
                    authenticityScoreView(result: result)
                        .padding(.top, 16)
                }

                // Selfie-only caption
                if !hasDocAnalysis && hasSelfie {
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 18))
                            .foregroundColor(primaryColor)
                        Text(t("selfieCapturedNoAnalysis"))
                            .font(.system(size: 13))
                            .foregroundColor(primaryColor)
                    }
                    .padding(12)
                    .background(primaryColor.opacity(0.08))
                    .cornerRadius(DS.smallR)
                    .padding(.top, 16)
                }

                // Error
                if let err = result.errorMessage {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "exclamationmark.circle")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                        Text(err)
                            .font(.system(size: 13))
                            .foregroundColor(.red.opacity(0.8))
                    }
                    .padding(12)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(DS.smallR)
                    .padding(.top, 16)
                }
            }
            .padding(DS.card)
            .background(statusColor.opacity(0.05))
            .cornerRadius(DS.cardR)
            .overlay(
                RoundedRectangle(cornerRadius: DS.cardR)
                    .stroke(statusColor.opacity(0.3), lineWidth: 1)
            )
            .opacity(didShowResult ? 1 : 0)
            .offset(y: didShowResult ? 0 : 20)
            .animation(.easeOut(duration: 0.4).delay(0.1), value: didShowResult)

            // ── Document images ──────────────────────────────────────────────
            if hasRecto || hasVerso || hasSelfie {
                documentImagesCard(result: result)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.2), value: didShowResult)
            }

            // ── Recto extracted data ─────────────────────────────────────────
            if let rectoFields = result.rectoResult?.extraction?.sortedFields, !rectoFields.isEmpty {
                extractedDataCard(stepName: "RECTO",
                                  fields: rectoFields,
                                  stepColor: primaryColor)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.3), value: didShowResult)
            }

            // ── Verso extracted data ─────────────────────────────────────────
            if let versoFields = result.versoResult?.extraction?.sortedFields, !versoFields.isEmpty {
                extractedDataCard(stepName: "VERSO",
                                  fields: versoFields,
                                  stepColor: primaryColor)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.3), value: didShowResult)
            }

            // ── Face verification ────────────────────────────────────────────
            if let fv = result.faceResult {
                faceVerificationCard(fv: fv)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.4), value: didShowResult)
            }

            // ── AML Screening ─────────────────────────────────────────────────
            if let aml = result.amlScreening {
                amlScreeningCard(aml: aml)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.4), value: didShowResult)
            }

            // ── Component scores ─────────────────────────────────────────────
            let rectoScores = result.rectoResult?.fraudAnalysis.componentScores ?? [:]
            let versoScores = result.versoResult?.fraudAnalysis.componentScores ?? [:]
            if !rectoScores.isEmpty || !versoScores.isEmpty {
                componentScoresCard(rectoScores: rectoScores, versoScores: versoScores)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.4), value: didShowResult)
            }

            // ── Processing times ─────────────────────────────────────────────
            if hasDocAnalysis {
                processingTimesCard(result: result)
                    .opacity(didShowResult ? 1 : 0)
                    .offset(y: didShowResult ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.5), value: didShowResult)
            }
        }
    }

    // MARK: Authenticity score

    private func authenticityScoreView(result: KYCResult) -> some View {
        let score = Int((result.authenticityScore * 100).rounded())
        let color: Color = score >= 70 ? primaryColor : (score >= 40 ? .orange : .red)
        var details: [String] = []
        if let rs = result.rectoAuthenticityScore { details.append("\(t("recto")): \(Int((rs * 100).rounded()))%") }
        if let vs = result.versoAuthenticityScore { details.append("\(t("verso")): \(Int((vs * 100).rounded()))%") }

        return HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(borderColor, lineWidth: 5)
                    .frame(width: 70, height: 70)
                Circle()
                    .trim(from: 0, to: result.authenticityScore)
                    .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 70, height: 70)
                Text("\(score)%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(t("authenticityScore"))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(textPrimary)
                if !details.isEmpty {
                    Text(details.joined(separator: " • "))
                        .font(.system(size: 12))
                        .foregroundColor(textSecondary)
                }
            }
            Spacer()
        }
        .padding(16)
        .background(cardColor)
        .cornerRadius(DS.btnR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.btnR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    // MARK: Document images card

    private func documentImagesCard(result: KYCResult) -> some View {
        let allPhotos = result.allExtractedPhotos
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "creditcard")
                    .font(.system(size: 18))
                    .foregroundColor(primaryColor)
                Text(t("scannedDocuments"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(textPrimary)
            }
            .padding(.bottom, 16)

            HStack(alignment: .top, spacing: 12) {
                if let data = result.rectoImage {
                    documentImageTile(data: data, label: t("recto"),
                                      aspectRatio: 1.53)
                }
                if let data = result.versoImage {
                    documentImageTile(data: data, label: t("verso"),
                                      aspectRatio: 1.53)
                }
            }

            // Selfie image
            if let data = result.selfieImage {
                Divider().background(borderColor).padding(.vertical, 16)
                HStack(spacing: 8) {
                    Image(systemName: "person")
                        .font(.system(size: 16))
                        .foregroundColor(textSecondary)
                    Text(t("selfie"))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(chipText)
                }
                .padding(.bottom, 12)
                HStack {
                    Spacer()
                    selfieTile(data: data)
                    Spacer()
                }
            }

            // Extracted photos
            if !allPhotos.isEmpty {
                Divider().background(borderColor).padding(.vertical, 16)
                HStack(spacing: 8) {
                    Image(systemName: "viewfinder.circle")
                        .font(.system(size: 16))
                        .foregroundColor(primaryColor)
                    Text("\(t("extractedPhotos")) (\(allPhotos.count))")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(chipText)
                }
                .padding(.bottom, 12)
                FlowLayout(spacing: 12) {
                    ForEach(allPhotos.indices, id: \.self) { idx in
                        let photo = allPhotos[idx]
                        extractedPhotoTile(photo: photo, index: idx)
                    }
                }
            }
        }
        .padding(16)
        .background(cardColor)
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    private func documentImageTile(data: Data, label: String, aspectRatio: CGFloat) -> some View {
        Button {
            popupImage = data
            popupTitle = label
            showImagePopup = true
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    if let uiImg = UIImage(data: data) {
                        Image(uiImage: uiImg)
                            .resizable()
                            .aspectRatio(aspectRatio, contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: DS.smallR))
                    }
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(DS.tinyR)
                        .padding(4)
                }
                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(textTertiary)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }

    private func selfieTile(data: Data) -> some View {
        Button {
            popupImage = data
            popupTitle = t("selfie")
            showImagePopup = true
        } label: {
            ZStack(alignment: .topTrailing) {
                if let uiImg = UIImage(data: data) {
                    Image(uiImage: uiImg)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: DS.btnR))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.btnR)
                                .stroke(primaryColor.opacity(0.3), lineWidth: 2)
                        )
                }
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(3)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(DS.tinyR)
                    .padding(4)
            }
        }
        .buttonStyle(.plain)
    }

    private func extractedPhotoTile(photo: ExtractedPhoto, index: Int) -> some View {
        Button {
            popupImage = photo.imageBytes
            popupTitle = "\(t("extractedPhoto")) \(index + 1)"
            showImagePopup = true
        } label: {
            VStack(spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    if let uiImg = UIImage(data: photo.imageBytes) {
                        Image(uiImage: uiImg)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: DS.smallR))
                            .overlay(
                                RoundedRectangle(cornerRadius: DS.smallR)
                                    .stroke(primaryColor.opacity(0.3), lineWidth: 2)
                            )
                    }
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(3)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(3)
                        .padding(2)
                }
                Text("\(photo.width)×\(photo.height)")
                    .font(.system(size: 10))
                    .foregroundColor(textTertiary)
                Text("\(Int((photo.confidence * 100).rounded()))% \(t("humanFace"))")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(primaryColor)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: Extracted data card

    private func extractedDataCard(stepName: String,
                                   fields: [ExtractedField],
                                   stepColor: Color) -> some View {
        // Sort by displayPriority before filtering so fields appear
        // in the same order as the Flutter reference app.
        let displayFields = fields
            .filter { ($0.stringValue ?? "").isEmpty == false && !$0.key.hasPrefix("mrz_line") }
        let mrzFromFields = fields.filter { $0.key.hasPrefix("mrz_line") && ($0.stringValue ?? "").isEmpty == false }
        let allMrz        = mrzFromFields.compactMap { $0.stringValue }

        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: stepName == "RECTO" ? "creditcard" : "rectangle.landscape.rotate")
                    .font(.system(size: 18))
                    .foregroundColor(stepColor)
                Text("\(stepName) (\(displayFields.count) \(t("fields")))")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(stepColor)
            }

            if displayFields.isEmpty && allMrz.isEmpty {
                Text(t("noExtractedData"))
                    .font(.system(size: 13))
                    .italic()
                    .foregroundColor(textTertiary)
            } else {
                ForEach(Array(displayFields.enumerated()), id: \.offset) { _, field in
                    dataTile(
                        label: field.label.isEmpty ? field.key : field.label,
                        value: field.stringValue ?? "",
                        icon:  iconForField(field.key)
                    )
                }

                if !allMrz.isEmpty {
                    Divider().background(borderColor)
                    HStack(spacing: 8) {
                        Image(systemName: "barcode.viewfinder")
                            .font(.system(size: 16))
                            .foregroundColor(textSecondary)
                        Text(t("mrz"))
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(chipText)
                    }
                    Text(allMrz.joined(separator: "\n"))
                        .font(.system(size: 11).monospaced())
                        .foregroundColor(textPrimary)
                        .lineSpacing(4)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(chipBg)
                        .cornerRadius(DS.smallR)
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.smallR)
                                .stroke(inputBorder, lineWidth: 1)
                        )
                }
            }
        }
        .padding(16)
        .background(cardColor)
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(stepColor.opacity(0.3), lineWidth: 1)
        )
    }

    private func dataTile(label: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(textTertiary)
                Text(label)
                    .font(.system(size: 10))
                    .foregroundColor(textTertiary)
                    .lineLimit(1)
            }
            Text(value)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(textPrimary)
                .lineLimit(2)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(inputBg)
        .cornerRadius(DS.smallR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.smallR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    // MARK: Face verification card

    private func faceVerificationCard(fv: FaceResult) -> some View {
        let isMatch   = fv.isMatch
        let color     = isMatch ? primaryColor : Color.red
        let similarity = Int((fv.similarityScore * 100).rounded())

        return VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: isMatch ? "person.fill.checkmark" : "person.fill.xmark")
                    .font(.system(size: 20))
                    .foregroundColor(color)
                Text(isMatch ? t("faceMatchResult") : t("faceNoMatchResult"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(color)
                Spacer()
                Text("\(similarity)%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(cardColor)
                    .cornerRadius(DS.pillR)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.pillR)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            }

            HStack(spacing: 8) {
                faceDetectionTile(label: "CIN Face",
                                  detected: fv.cinFaceDetected,
                                  confidence: fv.cinFaceConfidence)
                faceDetectionTile(label: "Selfie Face",
                                  detected: fv.selfieFaceDetected,
                                  confidence: fv.selfieFaceConfidence)
            }

            FlowLayout(spacing: 8) {
                modelTag("Detection: \(fv.detectionModel)")
                modelTag("Recognition: \(fv.recognitionModel)")
                modelTag("\(t("threshold")): \(Int((fv.threshold * 100).rounded()))%")
            }
        }
        .padding(16)
        .background(color.opacity(0.05))
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }

    private func faceDetectionTile(label: String, detected: Bool, confidence: Double) -> some View {
        HStack(spacing: 8) {
            Image(systemName: detected ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 16))
                .foregroundColor(detected ? primaryColor : .red)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 11))
                    .foregroundColor(textSecondary)
                    .lineLimit(1)
                Text(detected ? "\(Int((confidence * 100).rounded()))%" : t("notDetected"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(textPrimary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(inputBg)
        .cornerRadius(DS.smallR)
    }

    private func modelTag(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 10).monospaced())
            .foregroundColor(textSecondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(chipBg)
            .cornerRadius(DS.tinyR)
    }

    // MARK: Component scores card

    private func componentScoresCard(rectoScores: [String: Double], versoScores: [String: Double]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 18))
                    .foregroundColor(primaryColor)
                Text(t("componentScores"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(textPrimary)
            }
            if !rectoScores.isEmpty {
                Text(t("recto"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(chipText)
                componentScoresGrid(scores: rectoScores)
            }
            if !versoScores.isEmpty {
                Text(t("verso"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(chipText)
                componentScoresGrid(scores: versoScores)
            }
        }
        .padding(16)
        .background(cardColor)
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    private func componentScoresGrid(scores: [String: Double]) -> some View {
        let components: [(key: String, label: String)] = [
            ("overall",  t("overallScore")),
            ("liveness", t("liveness")),
        ]
        let valid = components.filter { scores[$0.key] != nil }
        return VStack(spacing: 8) {
            ForEach(valid, id: \.key) { item in
                let val   = Int(((scores[item.key] ?? 0) * 100).rounded())
                let color: Color = val >= 70 ? primaryColor : (val >= 40 ? .orange : .red)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(item.label)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(chipText)
                        Spacer()
                        Text("\(val)%")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(color)
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(borderColor)
                                .frame(height: 6)
                            RoundedRectangle(cornerRadius: 3)
                                .fill(color)
                                .frame(width: geo.size.width * CGFloat(scores[item.key] ?? 0).clamped(to: 0...1),
                                       height: 6)
                        }
                    }
                    .frame(height: 6)
                }
                .padding(10)
                .background(color.opacity(0.1))
                .cornerRadius(DS.smallR)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.smallR)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
            }
        }
    }

    // MARK: AML Screening card

    private func amlScreeningCard(aml: AMLScreening) -> some View {
        let isClear = aml.status == "clear"
        let isMatch = aml.status == "match"
        let color: Color = isClear ? primaryColor : (isMatch ? .red : .orange)
        let statusLabel: String = {
            switch aml.status {
            case "clear": return t("amlClear")
            case "match": return t("amlMatch")
            case "error": return t("amlError")
            default:      return t("amlDisabled")
            }
        }()

        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: isClear ? "checkmark.shield" : "exclamationmark.shield")
                    .foregroundColor(color)
                    .font(.system(size: 18))
                Text(t("amlScreening"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(color)
                Spacer()
                Text(aml.status.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(color)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(cardColor)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(color.opacity(0.3), lineWidth: 1))
            }
            HStack {
                Text(t("amlStatus")).font(.system(size: 13)).foregroundColor(textSecondary)
                Spacer()
                Text(statusLabel).font(.system(size: 13, weight: .semibold)).foregroundColor(color)
            }
            HStack {
                Text(t("amlRiskLevel")).font(.system(size: 13)).foregroundColor(textSecondary)
                Spacer()
                Text(aml.riskLevel.uppercased()).font(.system(size: 13, weight: .semibold)).foregroundColor(color)
            }
            if aml.totalMatches > 0 {
                HStack {
                    Text(t("amlMatches")).font(.system(size: 13)).foregroundColor(textSecondary)
                    Spacer()
                    Text("\(aml.totalMatches)").font(.system(size: 13, weight: .semibold)).foregroundColor(.red)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.05))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(color.opacity(0.3), lineWidth: 1))
        )
    }

    // MARK: Processing times card

    private func processingTimesCard(result: KYCResult) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .font(.system(size: 18))
                    .foregroundColor(primaryColor)
                Text(t("processingTime"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(textPrimary)
            }
            HStack(spacing: 8) {
                timeTile(label: t("total"), ms: result.totalProcessingTimeMs)
                if result.rectoImage != nil {
                    timeTile(label: t("recto"), ms: result.rectoResult?.processingTimeMs ?? 0)
                }
                if result.versoImage != nil {
                    timeTile(label: t("verso"), ms: result.versoResult?.processingTimeMs ?? 0)
                }
            }
        }
        .padding(16)
        .background(cardColor)
        .cornerRadius(DS.cardR)
        .overlay(
            RoundedRectangle(cornerRadius: DS.cardR)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    private func timeTile(label: String, ms: Int) -> some View {
        VStack(spacing: 4) {
            Text(String(format: "%.1fs", Double(ms) / 1000))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(primaryColor)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(primaryColor.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(primaryColor.opacity(0.1))
        .cornerRadius(DS.smallR)
    }

    // =========================================================================
    // MARK: - Color picker sheet
    // =========================================================================

    private let colorPickerColors: [Color] = [
        Color(hex: "EF4444"), Color(hex: "F97316"), Color(hex: "EF8352"), Color(hex: "F59E0B"), Color(hex: "EAB308"),
        Color(hex: "84CC16"), Color(hex: "22C55E"), Color(hex: "10B981"), Color(hex: "14B8A6"), Color(hex: "06B6D4"),
        Color(hex: "0EA5E9"), Color(hex: "3B82F6"), Color(hex: "6366F1"), Color(hex: "8B5CF6"), Color(hex: "A855F7"),
        Color(hex: "EC4899"), Color(hex: "F43F5E"), Color(hex: "00377D"), Color(hex: "FFD100"), Color(hex: "64748B"),
    ]

    private var colorPickerSheet: some View {
        VStack(spacing: 20) {
            Text(t("customColor"))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(textPrimary) // BUG 3 fix: was missing foregroundColor
                .padding(.top, 24)

            Circle()
                .fill(tempCustomColor)
                .frame(width: 60, height: 60)
                .shadow(color: tempCustomColor.opacity(0.4), radius: 12, x: 0, y: 4)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 5),
                      spacing: 8) {
                ForEach(colorPickerColors.indices, id: \.self) { idx in
                    let c = colorPickerColors[idx]
                    Button {
                        tempCustomColor = c
                    } label: {
                        Circle()
                            .fill(c)
                            .frame(width: 36, height: 36)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(color: c.opacity(0.3), radius: 4)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)

            HStack(spacing: 12) {
                Button(t("cancel")) {
                    showColorPicker = false
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(chipBg)
                .cornerRadius(DS.btnR)
                .foregroundColor(chipText)
                .buttonStyle(.plain)

                Button(t("apply")) {
                    customColor    = tempCustomColor
                    selectedTheme  = .custom
                    showColorPicker = false
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(primaryColor)
                .cornerRadius(DS.btnR)
                .foregroundColor(.white)
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .background(cardColor)
        .onAppear { tempCustomColor = customColor }
    }
}

// MARK: - CGFloat clamped helper

extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
    }
}

// MARK: - RefreshableScrollContent

/// A ScrollView content wrapper that wires up `.refreshable` (pull-to-refresh).
private struct RefreshableScrollContent<Content: View>: View {
    let onRefresh: () async -> Void
    let content:   () -> Content

    var body: some View {
        ScrollView {
            content()
        }
        .refreshable { await onRefresh() }
    }
}

// MARK: - FlowLayout (simple wrapping HStack)

/// A simple wrapping layout that places views left-to-right and wraps to the
/// next row when the current row is full — equivalent to Flutter's Wrap widget.
private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var origin   = CGPoint.zero
        var rowHeight: CGFloat = 0
        var totalHeight: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if origin.x + size.width > maxWidth, origin.x > 0 {
                origin.x  = 0
                origin.y += rowHeight + spacing
                totalHeight = origin.y
                rowHeight = 0
            }
            origin.x  += size.width + spacing
            rowHeight   = max(rowHeight, size.height)
        }
        totalHeight += rowHeight
        return CGSize(width: maxWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxWidth = bounds.width
        var origin   = bounds.origin
        var rowHeight: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if origin.x + size.width > bounds.maxX, origin.x > bounds.minX {
                origin.x  = bounds.minX
                origin.y += rowHeight + spacing
                rowHeight = 0
            }
            view.place(at: origin, anchor: .topLeading, proposal: ProposedViewSize(size))
            origin.x += size.width + spacing
            rowHeight  = max(rowHeight, size.height)
        }
    }
}

// MARK: - ImagePopupView

private struct ImagePopupView: View {
    let imageData:   Data
    let title:       String
    let chipText:    Color
    let textPrimary: Color
    let onClose:     () -> Void
    let onSave:      () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.87).ignoresSafeArea()

            InteractiveImageView(imageData: imageData)

            // Title at bottom
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        // Always use dark text on white pill — overlay is dark, so
                        // textPrimary would be white on white in dark mode (BUG 2 fix)
                        .foregroundColor(Color(hex: "111827"))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                    Spacer()
                }
                .padding(.bottom, 40)
            }

            // Top bar
            VStack {
                HStack {
                    // Save button
                    Button(action: onSave) {
                        Image(systemName: "arrow.down.to.line")
                            .font(.system(size: 20))
                            // Always dark icon on white circle — BUG 2 fix
                            .foregroundColor(Color(hex: "111827"))
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
                    }
                    Spacer()
                    // Close button
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            // Always dark icon on white circle — BUG 2 fix
                            .foregroundColor(Color(hex: "111827"))
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 60)
                Spacer()
            }
        }
    }
}

private struct InteractiveImageView: View {
    let imageData: Data
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        if let uiImg = UIImage(data: imageData) {
            Image(uiImage: uiImg)
                .resizable()
                .scaledToFit()
                .padding(20)
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in scale = lastScale * value }
                        .onEnded   { _     in lastScale = scale }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(
                                width:  lastOffset.width  + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in lastOffset = offset }
                )
                .onTapGesture(count: 2) {
                    withAnimation { scale = 1; lastScale = 1; offset = .zero; lastOffset = .zero }
                }
        }
    }
}
