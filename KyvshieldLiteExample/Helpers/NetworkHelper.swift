// NetworkHelper.swift
// KyvshieldLiteExample
//
// Thin URLSession helpers used by ContentView to fetch documents,
// check API health, and validate the API key.

import Foundation
import KyvshieldLite

// MARK: - NetworkHelper

enum NetworkHelper {

    static let apiBaseURL = "https://kyvshield-naruto.innolinkcloud.com"
    static let apiKey     = "kyvshield_demo_key_2024"

    // MARK: - Fetch documents

    /// Fetches the list of available documents from the API.
    /// - Parameter completion: Called on the main thread with either the
    ///   decoded list of documents or an `Error`.
    static func fetchDocuments(
        completion: @escaping (Result<[KyvshieldDocument], Error>) -> Void
    ) {
        guard let url = URL(string: "\(apiBaseURL)/api/v1/documents") else { return }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let docs  = json["documents"] as? [[String: Any]]
            else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "NetworkHelper",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                }
                return
            }
            let models = docs.map { KyvshieldDocument.fromJson($0) }
                             .filter { $0.enabled }
            DispatchQueue.main.async { completion(.success(models)) }
        }.resume()
    }

    // MARK: - Health check

    /// Hits `/health` and calls back with the status string and HTTP code.
    static func healthCheck(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(apiBaseURL)/health") else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                DispatchQueue.main.async { completion("Error: \(error.localizedDescription)") }
                return
            }
            let status: String
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let s = json["status"] as? String {
                status = "\(s) (\(code))"
            } else {
                status = "HTTP \(code)"
            }
            DispatchQueue.main.async { completion(status) }
        }.resume()
    }

    // MARK: - Validate API key

    /// Calls `/api/v1/validate-key` and returns a human-readable result.
    static func validateKey(completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "\(apiBaseURL)/api/v1/validate-key") else { return }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        URLSession.shared.dataTask(with: req) { data, response, error in
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                DispatchQueue.main.async { completion(false, error.localizedDescription) }
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else {
                DispatchQueue.main.async { completion(false, "HTTP \(code)") }
                return
            }
            if code == 200 {
                let name = json["application"] as? String
                         ?? json["app_name"] as? String
                         ?? "OK"
                DispatchQueue.main.async { completion(true, name) }
            } else {
                let msg = json["error"] as? String ?? "HTTP \(code)"
                DispatchQueue.main.async { completion(false, msg) }
            }
        }.resume()
    }
}

