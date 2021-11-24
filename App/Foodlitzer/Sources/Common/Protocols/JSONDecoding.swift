import Foundation

protocol JSONDecoding {
    func decode<T>(_: T.Type, from: Data) throws -> T where T: Decodable
}
