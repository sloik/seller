enum CustomException: Error {
    case setDataToKeychain(message: String)
    case getDataFromKeychain(message: String)
    case cannotConvertStringToData(message: String)
    case cannotDeleteDataFromGivenKey(message: String)
    
    var description: String {
        switch self {
        case .setDataToKeychain(let message):
            return message
        case .getDataFromKeychain(let message):
            return message
        case .cannotConvertStringToData(let message):
            return message
        case .cannotDeleteDataFromGivenKey(let message):
            return message
        }
    }
}
