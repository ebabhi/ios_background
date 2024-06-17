//
//  bckgrndApp.swift
//  bckgrnd
//
//  Created by ebpearls on 8/5/2024.
//

import SwiftUI
import BackgroundTasks

let BGAppRefreshTaskIdentifier : String = "BGAppRefreshTaskIdentifier"
let BGProcessingTaskIdentifier : String = "BGProcessingTaskIdentifier"

@main
struct bckgrndApp: App {
    
    
    func handleBGAppRefreshTask() {
        let data =  UserDefaults.standard.integer(forKey: BGAppRefreshTaskIdentifier)
        UserDefaults.standard.set(data + 1, forKey: BGAppRefreshTaskIdentifier)
        print("BGAppRefreshTask Executed<-----");
    }
    
    func handleBGProcessingTask() {
        let data =  UserDefaults.standard.integer(forKey: BGProcessingTaskIdentifier)
        UserDefaults.standard.set(data + 1, forKey: BGProcessingTaskIdentifier)
       
    }
    

    
    func canacelAllTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests();
    }
    
    var body: some Scene {
        WindowGroup {
           ContentView()
        }
        .backgroundTask(.appRefresh(BGAppRefreshTaskIdentifier)) { _ in
            handleBGAppRefreshTask()
        }
        .backgroundTask(.appRefresh(BGProcessingTaskIdentifier), action: { _ in
            handleBGProcessingTask()
        })
    }
}

