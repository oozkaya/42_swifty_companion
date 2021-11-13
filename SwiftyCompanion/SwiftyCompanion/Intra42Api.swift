//
//  Auth.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/12/21.
//

import Foundation
import OAuth2
import UIKit

class   Intra42Api: OAuth2DataLoader {

    let baseUrl: URL = URL(string: "https://api.intra.42.fr/v2/")!

    public init() {
        let oauth = OAuth2ClientCredentials(settings: [
            "client_id": "150f3e5c7950a85232ced09a485307770d49f4019a4df8a99f2c6f5d744c95c7",
            "client_secret": "8da9e2cac1aeadcd268ca81926d11dd96c37593a0fecf6994fd70fc86936ddfc",
            "authorize_uri": "https://api.intra.42.fr/oauth/authorize",
            "token_uri": "https://api.intra.42.fr/oauth/token",
            "redirect_uris": ["swiftyoozkaya://oauth/callback"],
            "scope": "public",
            "secret_in_body": true,
            "keychain": false
            ])
        super.init(oauth2: oauth)
    }

    func    getToken() {
        let tokenUrl = URL(string: "https://api.intra.42.fr/oauth/token/info")!
        let req = oauth2.request(forURL: tokenUrl)
        perform(request: req) { response in
            do {
                let dict = try response.responseJSON()
                dump(dict)
            }
            catch let error {
                print(error)
            }
        }
    }

    func    request(_ login: String, callback: @escaping ((OAuth2JSON?, Error?) -> Void)) {
//        Uncomment to check that the token is not changing at everycall
//        getToken()
        let loginUrl = baseUrl.appendingPathComponent("users/\(login)")
        let req = oauth2.request(forURL: loginUrl)
        perform(request: req) { response in
            do {
                let dict = try response.responseJSON()
                DispatchQueue.main.async {
                    callback(dict, nil)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    callback(nil, error)
                }
            }
        }
    }
}
