import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        return try await FileData.query(on: req.db).all()
    }
    
    app.post("upload") { req async throws in
        let file = try req.content.decode(FileData.self)
        try await file.create(on: req.db)
        print(file)
        return file
    }
    
    app.delete("delete", "all") { req async throws in
        let files = try await FileData.query(on: req.db).all()
        for file in files {
            try await file.delete(on: req.db)
        }
        return Response(status: .ok)
    }
    
    app.delete("delete", ":id") { req async throws in
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let file = try? await FileData.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await file.delete(on: req.db)
        
        return Response(status: .ok)
    }
}
