import Kitura
import CloudEnvironment

public func initializeCRUDResources(cloudEnv: CloudEnv, router: Router) throws {
    let factory = AdapterFactory(cloudEnv: cloudEnv)
    try UserResource(factory: factory).setupRoutes(router: router)
}
