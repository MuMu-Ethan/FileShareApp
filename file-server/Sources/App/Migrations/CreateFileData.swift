import Fluent


struct CreateFileData: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("files")
            .id()
            .field("fileName", .string, .required)
            .field("data", .data, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("files").delete()
    }
}
