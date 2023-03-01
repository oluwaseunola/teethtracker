//
//  AddEventView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-03-01.
//

import SwiftUI
import EventKitUI

struct EventEditView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    @Environment(\.presentationMode) var presentationMode

    let eventStore: EKEventStore
    let event: EKEvent?
    
    init(eventStore: EKEventStore, event: EKEvent?) {
        self.eventStore = eventStore
        self.event = event
        requestPermission()
    }
    
    private func requestPermission(){
        eventStore.requestAccess(to: .event) { success, error in
            if success {
                print("OK")
            } else {
                print(error)
            }
        }
        
        eventStore.requestAccess(to: .reminder) { success, error in
            if success {
                print("OK")
            } else {
                print(error)
            }
        }
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<EventEditView>) -> EKEventEditViewController {

        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.eventStore = eventStore

        if let event = event {
            eventEditViewController.event = event // when set to nil the controller would not display anything
        }
        eventEditViewController.editViewDelegate = context.coordinator

        return eventEditViewController
    }


    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: UIViewControllerRepresentableContext<EventEditView>) {

    }

    class Coordinator: NSObject, EKEventEditViewDelegate {
        let parent: EventEditView

        init(_ parent: EventEditView) {
            self.parent = parent
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()

            if action != .canceled {
              
            }
        }
    }
}
