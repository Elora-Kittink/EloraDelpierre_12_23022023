import FirebaseAuth


protocol MockAuthDataResultProtocol {
	
	static var mockUser: MockUser { get }
}

class MockUser: NSObject, UserInfo {
	
	let uid: String
	let email: String?
	

	
	var providerID: String {
		""
	}
	
	var displayName: String? {
		 nil
	}
	
	var photoURL: URL? {
		 nil
	}
	
	var phoneNumber: String? {
		 nil
	}
	
	var emailVerified: Bool {
		 false
	}
	
	init(uid: String, email: String?) {
		self.uid = uid
		self.email = email
	}
}

extension AuthDataResult: MockAuthDataResultProtocol {
	
	static var mockUser: MockUser {
		 MockUser(uid: "", email: "")
	}
}
