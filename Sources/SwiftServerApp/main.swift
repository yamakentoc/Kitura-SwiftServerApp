import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import Application
import SwiftyJSON

do {

    HeliumLogger.use(LoggerMessageType.info)
    let router = Router()
    
    router.get("/hello") { request, response, next in
        response.status(.OK).send("Hello, World!")
        next()
    }
    
    
    router.get("/hello.json") { request, response, next in
        response.status(.OK).send(json: ["Hello": "World!"])
        next()
    }

    Kitura.addHTTPServer(onPort: 8090, with: router)
    Kitura.run()
    
//    let app = try App()
//    try app.run()

} catch let error {
    Log.error(error.localizedDescription)
}
