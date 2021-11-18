struct RequestResponse<T>: Decodable where T: Decodable {
    let nextPageToken: String?
    let results: [T]
    let status: String

    enum CodingKeys: String, CodingKey {
        case nextPageToken = "next_page_token"
        case results
        case status
    }
}
