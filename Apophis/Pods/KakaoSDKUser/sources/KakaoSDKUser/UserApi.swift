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

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth

/// 카카오 Open API의 사용자관리 API 호출을 담당하는 클래스입니다.
final public class UserApi {
    
    // MARK: Fields

    /// 간편하게 API를 호출할 수 있도록 제공되는 공용 싱글톤 객체입니다.
    public static let shared = UserApi()

    // MARK: API Methods
    
    /// 사용자에 대한 다양한 정보를 얻을 수 있습니다.
    /// - seealso: `User`
    public func me(propertyKeys: [String]? = nil,
                   secureResource: Bool = true,
                   completion:@escaping (User?, Error?) -> Void) {
        AUTH.responseData(.get,
                          Urls.compose(path:Paths.userMe),
                          parameters: ["propertyKeys": propertyKeys, "secure_resource": secureResource].filterNil(),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(nil, error)
                                return
                            }
                            
                            if let data = data {
                                completion(try? SdkJSONDecoder.customIso8601Date.decode(User.self, from: data), nil)
                                return
                            }
                            
                            completion(nil, SdkError())
        }
    }
    
    /// User 클래스에서 제공되고 있는 사용자의 부가정보를 신규저장 및 수정할 수 있습니다.
    ///
    /// 저장 가능한 키 이름은 개발자 사이트의 [내 애플리케이션]  > [제품 설정] >  [카카오 로그인] > [사용자 프로퍼티] 메뉴에서 확인하실 수 있습니다. 앱 연결 시 기본 저장되는 nickanme, profile_image, thumbnail_image 값도 덮어쓰기 가능하며
    /// 새로운 컬럼을 추가하면 해당 키 이름으로 값을 저장할 수 있습니다.
    /// - seealso: `User.properties`
    public func updateProfile(properties: [String:Any],
                              completion:@escaping (Error?) -> Void) {
        AUTH.responseData(.post,
                          Urls.compose(path:Paths.userUpdateProfile),
                          parameters: ["properties": properties.toJsonString()].filterNil(),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(error)
                                return
                            }
                            
                            completion(nil)
        }
    }
    
    /// 현재 토큰의 기본적인 정보를 조회합니다. me()에서 제공되는 다양한 사용자 정보 없이 가볍게 토큰의 유효성을 체크하는 용도로 사용하는 경우 추천합니다.
    /// - seealso: `AccessTokenInfo`
    public func accessTokenInfo(completion:@escaping (AccessTokenInfo?, Error?) -> Void) {
        AUTH.responseData(.get,
                          Urls.compose(path:Paths.userAccessTokenInfo),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(nil, error)
                                return
                            }
                            
                            if let data = data {
                                completion(try? SdkJSONDecoder.custom.decode(AccessTokenInfo.self, from: data), nil)
                                return
                            }
                            
                            completion(nil, SdkError())
        }
    }
    
    /// 토큰을 강제로 만료시킵니다. 같은 사용자가 여러개의 토큰을 발급 받은 경우 로그아웃 요청에 사용된 토큰만 만료됩니다.
    public func logout(completion:@escaping (Error?) -> Void) {
        AUTH.responseData(.post,
                          Urls.compose(path:Paths.userLogout),
                          apiType: .KApi) { (response, data, error) in
                            
                            ///실패여부와 상관없이 토큰삭제.
                            AUTH.tokenManager.deleteToken()
                            
                            if let error = error {
                                completion(error)
                                return
                            }
                            
                            completion(nil)
        }
    }
    
    /// 카카오 플랫폼 서비스와 앱 연결을 해제합니다.
    public func unlink(completion:@escaping (Error?) -> Void) {
        AUTH.responseData(.post,
                          Urls.compose(path:Paths.userUnlink),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(error)
                                return
                            }
                            else {
                                AUTH.tokenManager.deleteToken()
                            }
                            
                            completion(nil)
        }
    }
    
    /// 앱에 가입한 사용자의 배송지 정보를 얻을 수 있습니다.
    /// - seealso: `UserShippingAddresses`
    public func shippingAddresses(fromUpdatedAt: Int? = nil, pageSize: Int? = nil, completion:@escaping (UserShippingAddresses?, Error?) -> Void) {
       AUTH.responseData(.get,
                         Urls.compose(path:Paths.userShippingAddress),
                         parameters: ["from_updated_at": fromUpdatedAt, "page_size": pageSize].filterNil(),
                         apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(nil, error)
                                return
                            }
                            
                            if let data = data {
                                completion(try? SdkJSONDecoder.customSecondsSince1970.decode(UserShippingAddresses.self, from: data), nil)
                                return
                            }
                            
                            completion(nil, SdkError())
        }
    }
    
    /// 앱에 가입한 사용자의 배송지 정보를 얻을 수 있습니다.
    /// - seealso: `UserShippingAddresses`
    public func shippingAddresses(addressId: Int64, completion:@escaping (UserShippingAddresses?, Error?) -> Void) {
        AUTH.responseData(.get,
                          Urls.compose(path:Paths.userShippingAddress),
                          parameters: ["address_id": addressId].filterNil(),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(nil, error)
                                return
                            }
                            
                            if let data = data {
                                completion(try? SdkJSONDecoder.customSecondsSince1970.decode(UserShippingAddresses.self, from: data), nil)
                                return
                            }
                            
                            completion(nil, SdkError())
        }
    }
    
    /// 사용자가 카카오 간편가입을 통해 동의한 서비스 약관 내역을 반환합니다.
    /// - seealso: `UserServiceTerms`
    public func serviceTerms(completion:@escaping (UserServiceTerms?, Error?) -> Void) {
        AUTH.responseData(.get,
                          Urls.compose(path:Paths.userServiceTerms),
                          apiType: .KApi) { (response, data, error) in
                            if let error = error {
                                completion(nil, error)
                                return
                            }
                            
                            if let data = data {
                                completion(try? SdkJSONDecoder.customIso8601Date.decode(UserServiceTerms.self, from: data), nil)
                                return
                            }
                            
                            completion(nil, SdkError())
        }
    }
}

