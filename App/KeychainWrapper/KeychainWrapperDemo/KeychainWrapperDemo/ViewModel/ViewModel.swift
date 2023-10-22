import KeychainWrapper
import SwiftUI

@Observable
class ViewModel: Keychainable {
    
    private let keychainWrapper: KeychainWrapper

    private(set) var keychainItems:[String:String] = [String:String]()

    init(keychainWrapper: KeychainWrapper) {
        self.keychainWrapper = keychainWrapper
        keychainItems = keychainItems.merging(keychainWrapper.allEntries, uniquingKeysWith: {current, _ in return current})
    }
    
    @discardableResult
    func saveValueToKeychain(_ stringToSave: String, keyValue: String) throws -> Bool {
        //TODO: Probably there is a way to use OptionalAPI here, but failed trying...
        
        if let data = stringToSave.data(using: .utf8) {
            if(keychainWrapper.set(data, key: keyValue)) {
                //update items to refresh binded views
                keychainItems[keyValue] = stringToSave
                return true
            } else {
                throw CustomException.setDataToKeychain(message: Constants.storeDataToKeychainException)
            }
        } else {
            throw CustomException.cannotConvertStringToData(message: Constants.stringEncodingException)
        }
    }
    
    func getValueFromKeychain(key: String) throws -> String {
        if let value = keychainWrapper.data(for: key) {
            if let string = String(data: value, encoding: .utf8) {
                return string
            } else {
                throw CustomException.getDataFromKeychain(message: Constants.dataDecodingException)
            }
        } else {
            throw CustomException.getDataFromKeychain(message: Constants.noDataUnderKeyException + key)
        }
        
    }
    
    @discardableResult
    func deleteKeychainValue(key: String) throws -> Bool {
        let status = keychainWrapper.delete(key: key)
        if(status) {
            //update items to refresh binded views
            keychainItems[key] = nil
            return status
        }
        throw CustomException.cannotDeleteDataFromGivenKey(message: Constants.deleteDataException)
    }
}






