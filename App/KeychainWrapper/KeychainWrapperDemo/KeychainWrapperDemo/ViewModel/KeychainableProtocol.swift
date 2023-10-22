protocol Keychainable {
    var keychainItems:[String:String] { get }
    func saveValueToKeychain(_ stringToSave: String, keyValue: String) throws -> Bool
    func getValueFromKeychain(key: String) throws -> String
    func deleteKeychainValue(key: String) throws -> Bool
}
