import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        APICaller.shared.search(query: "fac") { result in
//            switch result {
//            case .success(let response):
//                print(response)
////                DispatchQueue.main.async {
////                    resultVC.update(with: response.result)
////                    print(response.result)
////                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// https://finnhub.io/api/v1/search?q=apple&token=ciehpr1r01qmfas4dib0ciehpr1r01qmfas4dibg
// https://finnhub.io/api/v1/search?q=Apple&token=ciehpr1r01qmfas4dib0ciehpr1r01qmfas4dibg
