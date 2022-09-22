//
//  Server.swift
//  VaporSample
//
//  Created by Constantin Lungu on 22.09.2022.
//

import Foundation
import Vapor
import Photos
import UIKit

fileprivate enum Constants {
  static let port = 9090
}

class Server: ObservableObject {
  static private let server = Server()

  var environment: Environment
  var app: Application?

  init() {
    #if DEBUG
      environment = Environment.development
    #else
      environment = Environment.production
    #endif
  }

  static func start() {
    server.start()
  }

  static func shutdown() {
    server.shutdown()
  }

  private func start() {
    guard app == nil else { return }

    let application = Application(environment)
    configure(application)

    app = application

    Task(priority: .background) {
      do {
        guard let app, !app.didShutdown else { return }

        try app.start()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }

  private func shutdown() {
    if let appl = app {
      app = nil
      appl.shutdown()
    }
  }

  private func configure(_ app: Application) {
    app.http.server.configuration.port = Constants.port

    app.get("hello") { req -> String in
      return "Hello, Vapor!"
    }
  }
}
