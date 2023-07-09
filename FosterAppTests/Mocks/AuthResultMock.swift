import FirebaseAuth

protocol MockAuthDataResultProtocol {
	
	static var mockUser: MockUser { get }
}

extension AuthDataResult: MockAuthDataResultProtocol {
	
	static var mockUser: MockUser {
		return MockUser(uid: "", email: "")
	}
}

class MockUser: NSObject, UserInfo {
	
	let uid: String
	let email: String?
	
	init(uid: String, email: String?) {
		self.uid = uid
		self.email = email
	}
	
	var providerID: String {
		return ""
	}
	
	var displayName: String? {
		return nil
	}
	
	var photoURL: URL? {
		return nil
	}
	
	var phoneNumber: String? {
		return nil
	}
	
	var emailVerified: Bool {
		return false
	}
}

