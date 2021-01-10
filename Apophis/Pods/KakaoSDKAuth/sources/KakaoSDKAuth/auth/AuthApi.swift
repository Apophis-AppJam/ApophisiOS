//  Copyright 2019 Kakao Corp.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit
import Foundation
import KakaoSDKCommon

/// 카카오 로그인의 주요 기능을 제공하는 클래스입니다.
///
/// 이 클래스를 이용하여 **카카오톡 간편로그인** 또는 **카카오계정 로그인** 으로 로그인을 수행할 수 있습니다.
///
/// 카카오톡 간편로그인 예제입니다.
///
///     // 로그인 버튼 클릭
///     if (AuthApi.isKakaoTalkLoginAvailable()) {
///         AuthApi.shared.loginWithKakaoTalk()
///     }
///
///     // AppDelegate
///     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
///         if (AuthController.isKakaoTalkLoginUrl(url)) {
///             if AuthController.handleOpenUrl(url: url, options: options) {
///                 return true
///             }
///         }
///         ...
///     }
///
/// 카카오계정 로그인 예제입니다.
///
///     AuthApi.shared.loginWithKakaoAccount()
///


/// 카카오 로그인 인증서버로 API 요청을 담당하는 클래스입니다.
///
final public class AuthApi {
    
    /// 간편하게 API를 호출할 수 있도록 제공되는 공용 싱글톤 객체입니다.
    public static let shared = AuthApi()
    
    // MARK: Methods
    
    // MARK: Login with KakaoTalk
    
    /// 카카오톡 간편로그인이 실행 가능한지 확인합니다.
    ///
    /// 내부적으로 UIApplication.shared.canOpenURL() 메소드를 사용합니다. 카카오톡 간편로그인을 위한 커스텀 스킴은 "kakaokompassauth"이며 이 메소드를 정상적으로 사용하기 위해서는 LSApplicationQueriesSchemes에 해당 스킴이 등록되어야 합니다.
    /// 등록되지 않은 상태로 메소드를 호출하면 카카오톡이 설치되어 있더라도 항상 false를 반환합니다.
    ///
    /// ```xml
    /// // info.plist
    /// <key>LSApplicationQueriesSchemes</key>
    /// <array>
    ///   <string>kakaokompassauth</string>
    /// </array>
    /// ```
    public static func isKakaoTalkLoginAvailable() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string:Urls.compose(.TalkAuth, path:Paths.authTalk))!)
    }
    
    /// 카카오톡 으로부터 리다이렉트 된 URL 인지 체크합니다.
    public static func isKakaoTalkLoginUrl(_ url:URL) -> Bool {
        if url.absoluteString.hasPrefix(KakaoSDKCommon.shared.redirectUri()) {
            return true
        }
        return false
    }
    
    /// 카카오톡 간편로그인을 실행합니다.
    /// - note: AuthApi.isKakaoTalkLoginAvailable() 메소드로 실행 가능한 상태인지 확인이 필요합니다. 카카오톡을 실행할 수 없을 경우 loginWithKakaoAccount() 메소드로 웹 로그인을 시도할 수 있습니다.
    public func loginWithKakaoTalk(channelPublicIds: [String]? = nil,
                                   serviceTerms: [String]? = nil,
                                   completion: @escaping (OAuthToken?, Error?) -> Void) {
        
        AuthController.shared.authorizeWithTalk(channelPublicIds:channelPublicIds,
                                                serviceTerms:serviceTerms,
                                                completion:completion)
        
    }
    

    // MARK: Login with Kakao Account
    
    /// iOS 11 이상에서 제공되는 (SF/ASWeb)AuthenticationSession 을 이용하여 로그인 페이지를 띄우고 쿠키 기반 로그인을 수행합니다. 이미 사파리에에서 로그인하여 카카오계정의 쿠키가 있다면 이를 활용하여 ID/PW 입력 없이 간편하게 로그인할 수 있습니다.
    public func loginWithKakaoAccount(authType: AuthType? = nil, completion: @escaping (OAuthToken?, Error?) -> Void) {
        AuthController.shared.authorizeWithAuthenticationSession(authType: authType, completion:completion)
    }
    
    // MARK: New Agreement
    
    /// 사용자로부터 카카오가 보유중인 사용자 정보 제공에 대한 동의를 받습니다.
    ///
    /// 카카오로부터 사용자의 정보를 제공 받거나 카카오서비스 접근권한이 필요한 경우, 사용자로부터 해당 정보 제공에 대한 동의를 받지 않았다면 이 메소드를 사용하여 **추가 항목 동의**를 받아야 합니다.
    /// 필요한 동의항목과 매칭되는 scope id를 배열에 담아 파라미터로 전달해야 합니다. 동의항목과 scope id는 카카오 디벨로퍼스의 [내 애플리케이션] > [제품 설정] > [카카오 로그인] > [동의항목]에서 확인할 수 있습니다.
    ///
    /// ## 사용자 동의 획득 시나리오
    /// 간편로그인 또는 웹 로그인을 수행하면 최초 로그인 시 카카오 디벨로퍼스에 설정된 동의항목 설정에 따라 사용자의 동의를 받습니다. 동의항목을 설정해도 상황에 따라 동의를 받지 못할 수 있습니다. 대표적인 케이스는 아래와 같습니다.
    /// - **선택 동의** 로 설정된 동의항목이 최초 로그인시 선택받지 못한 경우
    /// - **필수 동의** 로 설정하였지만 해당 정보가 로그인 시점에 존재하지 않아 카카오에서 동의항목을 보여주지 못한 경우
    /// - 사용자가 해당 동의항목이 설정되기 이전에 로그인한 경우
    ///
    /// 이외에도 다양한 여건에 따라 동의받지 못한 항목이 발생할 수 있습니다.
    ///
    /// ## 추가 항목 동의 받기 시 주의사항
    /// **선택 동의** 으로 설정된 동의항목에 대한 **추가 항목 동의 받기**는, 반드시 **사용자가 동의를 거부하더라도 서비스 이용이 지장이 없는** 시나리오에서 요청해야 합니다.
    
    public func loginWithKakaoAccount(scopes:[String],
                                      completion: @escaping (OAuthToken?, Error?) -> Void) {
        AuthController.shared.authorizeWithAuthenticationSession(scopes:scopes, completion:completion)
    }
    
    /// :nodoc: 카카오싱크 전용입니다. 자세한 내용은 카카오싱크 전용 개발가이드를 참고하시기 바랍니다.
    public func loginWithKakaoAccount(authType: AuthType? = nil,
                                      channelPublicIds: [String]? = nil,
                                      serviceTerms: [String]? = nil,                                      
                                      completion: @escaping (OAuthToken?, Error?) -> Void) {
        
        AuthController.shared.authorizeWithAuthenticationSession(authType: authType,
                                                                 channelPublicIds: channelPublicIds,
                                                                 serviceTerms: serviceTerms,
                                                                 completion: completion)
    }
    
    
    
    /// :nodoc: 인증코드 요청입니다.
    public func authorizeRequest(parameters:[String:Any]) -> URLRequest? {
        guard let finalUrl = SdkUtils.makeUrlWithParameters(Urls.compose(.Kauth, path:Paths.authAuthorize), parameters:parameters) else { return nil }
        return URLRequest(url: finalUrl)
    }
    
    /// :nodoc: 추가 항목 동의 받기 요청시 인증값으로 사용되는 임시토큰 발급 요청입니다. SDK 내부 전용입니다.
    public func agt(completion:@escaping (String?, Error?) -> Void) {
        API.responseData(.post,
                                Urls.compose(.Kauth, path:Paths.authAgt),
                                parameters: ["client_id":try! KakaoSDKCommon.shared.appKey(), "access_token":AUTH.tokenManager.getToken()?.accessToken].filterNil(),
                                sessionType:.Auth,
                                apiType: .KAuth) { (response, data, error) in
                                    if let error = error {
                                        completion(nil, error)
                                        return
                                    }
                                    
                                    if let data = data {
                                        if let json = (try? JSONSerialization.jsonObject(with:data, options:[])) as? [String: Any] {
                                            completion(json["agt"] as? String, nil)
                                            return
                                        }
                                    }
                                    
                                    completion(nil, SdkError())
                                }
    }
    
    /// 사용자 인증코드를 이용하여 신규 토큰 발급을 요청합니다.
    public func token(code: String,
                      codeVerifier: String? = nil,
                      redirectUri: String = KakaoSDKCommon.shared.redirectUri(),
                      completion:@escaping (OAuthToken?, Error?) -> Void) {
        API.responseData(.post,
                                Urls.compose(.Kauth, path:Paths.authToken),
                                parameters: ["grant_type":"authorization_code",
                                             "client_id":try! KakaoSDKCommon.shared.appKey(),
                                             "redirect_uri":redirectUri,
                                             "code":code,
                                             "code_verifier":codeVerifier,
                                             "ios_bundle_id":Bundle.main.bundleIdentifier,
                                             "approval_type":KakaoSDKCommon.shared.approvalType().type].filterNil(),
                                sessionType:.Auth,
                                apiType: .KAuth) { (response, data, error) in
                                    if let error = error {
                                        completion(nil, error)
                                        return
                                    }
                                    
                                    if let data = data {
                                        if let oauthToken = try? SdkJSONDecoder.custom.decode(OAuthToken.self, from: data) {
                                            AUTH.tokenManager.setToken(oauthToken)
                                            completion(oauthToken, nil)
                                            return
                                        }
                                    }
                                    completion(nil, SdkError())
                                }
    }
    
    /// 기존 토큰을 갱신합니다.
    public func refreshAccessToken(refreshToken: String? = nil,
                                   completion:@escaping (OAuthToken?, Error?) -> Void) {
        API.responseData(.post,
                                Urls.compose(.Kauth, path:Paths.authToken),
                                parameters: ["grant_type":"refresh_token",
                                             "client_id":try! KakaoSDKCommon.shared.appKey(),
                                             "refresh_token":refreshToken ?? AUTH.tokenManager.getToken()?.refreshToken,
                                             "ios_bundle_id":Bundle.main.bundleIdentifier,
                                             "approval_type":KakaoSDKCommon.shared.approvalType().type].filterNil(),
                                sessionType:.Auth,
                                apiType: .KAuth) { (response, data, error) in
                                    if let error = error {
                                        completion(nil, error)
                                        return
                                    }
                                    
                                    if let data = data {
                                        if let newToken = try? SdkJSONDecoder.custom.decode(Token.self, from: data) {
                                        
                                            //oauthtoken 객체가 없으면 에러가 나야함.
                                            guard let oldOAuthToken = AUTH.tokenManager.getToken()
                                            else {
                                                completion(nil, SdkError(reason: .TokenNotFound))
                                                return
                                            }
                                            
                                            var newRefreshToken: String {
                                                if let refreshToken = newToken.refreshToken {
                                                    return refreshToken
                                                }
                                                else {
                                                    return oldOAuthToken.refreshToken
                                                }
                                            }
                                            
                                            var newRefreshTokenExpiresIn : TimeInterval {
                                                if let refreshTokenExpiresIn = newToken.refreshTokenExpiresIn {
                                                    return refreshTokenExpiresIn
                                                }
                                                else {
                                                    return oldOAuthToken.refreshTokenExpiresIn
                                                }
                                            }
                                            
                                            let oauthToken = OAuthToken(accessToken: newToken.accessToken,
                                                                        expiresIn: newToken.expiresIn,
                                                                        tokenType: newToken.tokenType,
                                                                        refreshToken: newRefreshToken,
                                                                        refreshTokenExpiresIn: newRefreshTokenExpiresIn,
                                                                        scope: newToken.scope,
                                                                        scopes: newToken.scopes)
                                            
                                            AUTH.tokenManager.setToken(oauthToken)
                                            completion(oauthToken, nil)
                                            return
                                        }
                                    }
                                    
                                    completion(nil, SdkError())
                                }
    }   
}


/// Kakao Account Authentication Type
public enum AuthType : String {
    /// 재로그인
    case Reauthenticate = "reauthenticate"
}
