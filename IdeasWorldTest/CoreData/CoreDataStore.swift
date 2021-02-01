//
//  CoreDataStore.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol CoreDataStoreProtocol {
    /// Synchronously performs the given block on the view context’s queue (main queue).
    ///
    /// Should be used to fetch entities for presentation.
    /// - Parameter block: The block to perform.
    /// - Parameter context: The view context on which the block will be executed.
    func performOnMainQueue(_ block: @escaping (_ context: NSManagedObjectContext) throws -> Void) throws
    
    /// Asynchronously performs the given block on a private dispatch queue and saves any changes.
    ///
    /// The changes are initially written to a child context of the view context. After execution of the block, the changes
    /// are saved to the view context.
    /// Should be used when writing to core data (creating new or updating existing entities).
    /// - Parameter block: The block to perform.
    /// - Parameter context: The background context on which the block will be executed.
    func performOnBackgroundQueue(_ block: @escaping (_ context: NSManagedObjectContext) -> Void)
}

class CoreDataStore: CoreDataStoreProtocol {

    // MARK: - Private Properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: constants.name)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                debugPrint("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - External Dependencies
    
    private let constants: CoreDataConstantProtocol
    
    // MARK: - Lifecycle

    init(constants: CoreDataConstantProtocol = CoreDataConstant()) {
        self.constants = constants
    }

    // MARK: - Public Functions

    func performOnMainQueue(_ block: @escaping (NSManagedObjectContext) throws -> Void) throws {
        mainContext.performAndWait {
            do {
                try block(mainContext)
            } catch {
                debugPrint(error)
            }
        }
    }

    func performOnBackgroundQueue(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childContext.parent = mainContext
        childContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        childContext.perform {
            block(childContext)
            self.saveContext(childContext)
        }
    }

    // MARK: - Private Functions

    private func saveContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                guard context.hasChanges else { return }
                try context.save()
                guard let parent = context.parent else { return }
                parent.perform {
                    do {
                        try parent.save()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
