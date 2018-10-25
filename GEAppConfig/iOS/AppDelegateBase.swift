//
//  AppDelegateBase.swift
//  RSSReaderAppConfig
//
//  Created by Grigory Entin on 08/10/2016.
//  Copyright © 2016 Grigory Entin. All rights reserved.
//

import func GEUIKit.openSettingsApp
import GEDebugKit
import var GEUIKit.urlTaskGeneratorProgressBinding 
import func GEFoundation.loadDefaultsFromSettingsPlistAtURL
import var GEFoundation.versionIsClean
import var GEFoundation.buildAge
#if DEBUG
import var GEFoundation.nslogRedirectorInitializer
#endif
#if LOGGY_ENABLED
import Loggy
#endif
import UIKit

let analyticsShouldBeEnabled: Bool = {
	let mainBundleURL = Bundle.main.bundleURL
	return x$(versionIsClean) && !x$(mainBundleURL).lastPathComponent.hasPrefix("Test")
}()

open class AppDelegateBase : UIResponder, UIApplicationDelegate {
	public var window: UIWindow?
	final var retainedObjects = [Any]()
	// MARK: -
	@IBAction public func openSettings(_ sender: AnyObject?) {
		openSettingsApp()
	}
	// MARK: -
	
	func applicationShouldHaveMainWindow() {
		
		_ = networkActivityIndicatorInitializer
	}
	
	open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        configureDebug()
        
		#if false
		if x$(analyticsShouldBeEnabled) {
			launchOptimizely(launchOptions: launchOptions)
			configureFirebase()
		}
		#endif
		
		_ = urlTaskGeneratorProgressBinding
		
		DispatchQueue.main.async {
			
			self.applicationShouldHaveMainWindow()
		}
		return true
	}
    
	// MARK: -
    
    private func initializeBasics() {
        let defaultsPlistURL = Bundle.main.url(forResource: "Settings", withExtension: "bundle")!.appendingPathComponent("Root.plist")
        try! loadDefaultsFromSettingsPlistAtURL(defaultsPlistURL)
        
        initializeDebug()
        
        let fileManager = FileManager()
        let libraryDirectoryURL = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).last!
        let libraryDirectory = libraryDirectoryURL.path
        x$(libraryDirectory)
    }
    
	public override init() {
		_ = AppDelegateBase.initializeOnce
		super.init()
        #if LOGGY_ENABLED
		Activity.label("Basic Initialization") {
            initializeBasics()
		}
        #else
        initializeBasics()
        #endif
	}
    
	// MARK: -
    
    private static func initializeAnalytics() {
        #if DEBUG
        _ = nslogRedirectorInitializer
        #endif
        #if WATCHDOG_ENABLED
        _ = watchdogInitializer
        #endif
        x$(buildAge)
        _ = coreDataDiagnosticsInitializer
        if x$(analyticsShouldBeEnabled) {
            _ = crashlyticsInitializer
            _ = appseeInitializer
            _ = uxcamInitializer
            _ = flurryInitializer
            _ = mixpanelInitializer
        }
    }

	static private let initializeOnce: Ignored = {
        #if LOGGY_ENABLED
		return Activity.label("Initializing Analytics") {
            initializeAnalytics()
			return Ignored()
		}
        #else
        initializeAnalytics()
        return Ignored()
        #endif
	}()
}