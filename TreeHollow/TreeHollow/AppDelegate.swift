//
//  AppDelegate.swift
//  TreeHollow
//
//  Created by Rachel Deng on 4/22/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?
    static var usertoken: String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(Keys.googleClientIdKey.value)
        GIDSignIn.sharedInstance()?.clientID = "1054326645687-jqg2n4pf3iqdufsgni9blo7kcpu6ljed.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        //GIDSignIn.sharedInstance().signOut()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            GIDSignIn.sharedInstance()?.signInSilently()
            print("user is signed in")
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
        }else{
            window?.rootViewController = UINavigationController(rootViewController: WelcomePageViewController())
        }
        
        //window?.rootViewController = UINavigationController(rootViewController: UsernameViewController())
        window?.makeKeyAndVisible()
        return true
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("sign in called")
        if let error = error{
            print(error.localizedDescription)
            return
        }
        AppDelegate.usertoken = user.authentication.accessToken
        
        NetworkManager.getUser { (response) in
            if response.success {
                let viewController = ViewController()
                self.window?.rootViewController = UINavigationController(rootViewController: viewController)
            }else{
                let usernameViewController = UsernameViewController()
                self.window?.rootViewController = UINavigationController(rootViewController: usernameViewController)
            }
        }
        
        
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

