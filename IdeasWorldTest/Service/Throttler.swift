//
//  Throttler.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import Foundation

/// Throttler
protocol ThrottlerProtocol {
    /// Performing throttle
    ///
    /// - Parameter block: Closure to be completed in a 'minimumDelay' time.
    func throttle(_ block: @escaping () -> Void)
}

class Throttler: ThrottlerProtocol {

    // MARK: - Private Properties

    private var previousRun = Date.distantPast

    // MARK: - External Dependencies

    private var workItem: DispatchWorkItem
    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval

    // MARK: - Lifecycle

    init(
        minimumDelay: TimeInterval,
        queue: DispatchQueue = DispatchQueue.global(qos: .background),
        workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    ) {
        self.minimumDelay = minimumDelay
        self.queue = queue
        self.workItem = workItem
    }

    // MARK: - Public Functions

    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()

        workItem = DispatchWorkItem { [weak self] in
            self?.previousRun = Date()
            block()
        }

        let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
