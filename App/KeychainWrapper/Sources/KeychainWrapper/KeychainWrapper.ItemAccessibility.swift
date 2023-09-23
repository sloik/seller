
import Foundation

extension KeychainWrapper {

    /// Predefined item attribute constants used to get or set values
    /// in a dictionary. The `kSecAttrAccessible` constant is the key
    /// and its value is one of the constants defined here.
    enum ItemAccessibility: String {

        /// Case for `kSecAttrAccessibleWhenUnlocked`.
        ///
        /// Item data can only be accessed while the device is unlocked.
        /// This is recommended for items that only need be accessible while
        /// the application is in the foreground.  Items with this attribute
        /// will migrate to a new device when using encrypted backups.
        case whenUnlocked = "kSecAttrAccessibleWhenUnlocked"

        /// Case for `kSecAttrAccessibleAfterFirstUnlock`
        ///
        /// Item data can only be accessed once the device has been unlocked
        /// after a restart.  This is recommended for items that need to be
        /// accessible by background applications. Items with this attribute
        /// will migrate to a new device when using encrypted backups.
        case afterFirstUnlock = "kSecAttrAccessibleAfterFirstUnlock"

        /// Case for `kSecAttrAccessibleAlways`
        ///
        /// Item data can always be accessed regardless of the lock state of the device.
        /// This is not recommended for anything except system use. Items with this
        /// attribute will migrate to a new device when using encrypted backups.
        case always = "kSecAttrAccessibleAlways"

        /// Case for `kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly`
        ///
        /// Item data can only be accessed while the device is unlocked. This is
        /// recommended for items that only need to be accessible while the application
        /// is in the foreground and requires a passcode to be set on the device. Items
        /// with this attribute will never migrate to a new device, so after a backup
        /// is restored to a new device, these items will be missing. This attribute
        /// will not be available on devices without a passcode. Disabling the device
        /// passcode will cause all previously protected items to be deleted.
        case whenPasscodeSetThisDeviceOnly = "kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly"

        /// Case for `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`
        ///
        /// Item data can only be accessed while the device is unlocked.
        /// This is recommended for items that only need be accessible while
        /// the application is in the foreground. Items with this attribute
        /// will never migrate to a new device, so after a backup is restored
        /// to a new device, these items will be missing.
        case whenUnlockedThisDeviceOnly = "kSecAttrAccessibleWhenUnlockedThisDeviceOnly"

        /// Case for `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`
        ///
        /// Item data can only be accessed once the device has been unlocked after a restart.
        /// This is recommended for items that need to be accessible by background
        /// applications. Items with this attribute will never migrate to a new
        /// device, so after a backup is restored to a new device these items will
        /// be missing.
        case afterFirstUnlockThisDeviceOnly = "kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly"

        /// Case for `kSecAttrAccessibleAlwaysThisDeviceOnly`
        ///
        /// Item data can always be accessed regardless of the lock state of the device.
        /// This option is not recommended for anything except system use. Items with this
        /// attribute will never migrate to a new device, so after a backup is restored to
        /// a new device, these items will be missing.
        case alwaysThisDeviceOnly = "kSecAttrAccessibleAlwaysThisDeviceOnly"

        init?(_ accessibility: CFString) {
            self.init(rawValue: accessibility as String)
        }
    }
}
