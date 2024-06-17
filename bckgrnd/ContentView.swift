//
//  ContentView.swift
//  bckgrnd
//
//  Created by ebpearls on 8/5/2024.
//

import SwiftUI
import BackgroundTasks

struct ContentView: View {
    
    @State var  currentPendingTasks : String = ""
    
    
    var executionNumer : String {
        let data =   UserDefaults.standard.integer(forKey: BGProcessingTaskIdentifier)
        return "\(data)"
    }
    
    var body: some View {
        VStack {
            Text("Pending Tasks : \(currentPendingTasks)")
                .padding(8)
            Text("Background iteration")
            Text(executionNumer)
            Button("schedule task") {
                scheduleBGProcessingTask()
            }.padding(8)
            Button("cancel task") {
                cancealalltasks();
            }.padding(8)
            Button("print sceduled task") {
                printPendingTask()
            }.padding(8)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    func scheduleBGAppRefreshTask() {
        BGTaskScheduler.shared.getPendingTaskRequests(completionHandler: { request in
            if request.isEmpty {
                let request = BGAppRefreshTaskRequest(identifier: BGAppRefreshTaskIdentifier)
                request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
                do{
                    try BGTaskScheduler.shared.submit(request)
                    print("Scheduled")
                }catch{
                    print(error)
                }
            }
        })
    }
    
    func scheduleBGProcessingTask() {
        BGTaskScheduler.shared.getPendingTaskRequests(completionHandler: { request in
            if request.isEmpty {
                let request = BGProcessingTaskRequest(identifier: BGProcessingTaskIdentifier)
                request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
                do{
                    try BGTaskScheduler.shared.submit(request)
                    print("Scheduled")
                    
                }catch{
                    print(error)
                }
            }
        })
    }
    
    func printPendingTask() {
        BGTaskScheduler.shared.getPendingTaskRequests(completionHandler: { request in
            currentPendingTasks  = "\(request)"
        })
    }
    
    func cancealalltasks() {
        BGTaskScheduler.shared.cancelAllTaskRequests();
    }
}
