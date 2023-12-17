
import Onion
import AliasWonderland

class MockLoginHandler: LoginHandlerType {

    var tokenProducer: Producer<String>?
    var token: String? { tokenProducer?() }

    var logoutClosure: SideEffectClosure?
    func logout() {
        logoutClosure?()
    }
    
    var refreshTokenClosure: AsyncThrowsConsumer<Void>?
    func refreshToken() async throws {
        try await refreshTokenClosure?( () )
    }

}
