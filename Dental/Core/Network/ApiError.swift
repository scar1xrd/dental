//
//  ApiError.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case server(error: Error?)
    case client(data: Data?)
    case notJson
    case parsing
    case noData
    case noConnection
    case unauthorizedError
    case wrongURL
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .server:            return "Ошибка сервера"
        case .notJson:           return "Неверный формат данных. Попробуйте позднее"
        case .parsing:           return "Не удалось раскодировать ответ. Попробуйте позднее"
        case .noData:            return "Не удалось выполнить запрос"
        case .noConnection:      return "Отсутствует интернет соединение"
        case .unauthorizedError: return "Пользователь не авторизован"
        case .wrongURL:          return "Не правильный адрес, повторите запрос позднее"
        case .unknown:           return "Что-то пошло не так, попробуйте позже"
        case .client(let data):  return handleClientError(data)
        }
    }
    
    private func handleClientError(_ data: Data?) -> String {
        guard let data = data else { return ApiError.parsing.localizedDescription }
        
        var json: [String: Any]? = [:]
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            return ApiError.parsing.localizedDescription
        }
        
        if let errorMessage = json?["reason"] as? String {
            return errorMessage
        }
        
        return ApiError.unknown.localizedDescription
    }
}
