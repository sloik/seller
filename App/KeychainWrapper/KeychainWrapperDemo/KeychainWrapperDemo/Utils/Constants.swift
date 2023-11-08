import Foundation

internal struct Constants {
    
    //Save
    static var saveSectionHeaderTitle = "Save value to keychain"
    static var saveSectionTextFieldValue = "type value to save"
    static var saveSectionTextFieldKeyValue = "type key for saved value"
    
    //Retrieve
    static var getValueHeaderTitle = "Get Value from keychain"
    static var getButtonTtile = "Read value"
    static var getSectionTextFieldKeyValue = "type key for saved value"
    
    //ListView
    static var noValueUnderKey = "No value found under given key"
    static var listViewHeadeTitle = "All Keychain entries"
    static var iconName = "info.circle"
    
    //Other
    static var error = "Error!!!"
    static var ok = "OK"
    static var unknownError = "Unknown Error!!!"
    
    //Exception messages:
    static var storeDataToKeychainException = "Can't set data to keychain"
    static var stringEncodingException = "Can't encode string to data"
    static var dataDecodingException = "Can't decode data"
    static var noDataUnderKeyException = "There is no data under key: "
    static var deleteDataException = "Can't delete data"
}
