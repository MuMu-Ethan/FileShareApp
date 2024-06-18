import Fluent
import Foundation
import Vapor


final class FileData: Model, Content {
    
    static let schema = "files"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "fileName")
    var fileName: String
    
    @Field(key: "data")
    var data: Data
    
    init() { }
 
    init(id: UUID? = nil, fileName: String, data: Data) {
        self.id = id
        self.fileName = fileName
        self.data = data
    }
    
}
