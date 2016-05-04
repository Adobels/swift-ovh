//
//  OVHVPS.swift
//
//  Copyright (c) 2016, OVH SAS.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  * Neither the name of OVH SAS nor the
//  names of its contributors may be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY OVH SAS AND CONTRIBUTORS ``AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL OVH SAS AND CONTRIBUTORS BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation
import CoreData


class OVHVPS: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func isBusy() -> Bool {
        return (state != OVHVPSState.running.rawValue && state != OVHVPSState.stopped.rawValue) || currentTask != nil //|| waitingTask
    }
    
    func isRunning() -> Bool {
        return state == OVHVPSState.running.rawValue
    }
    
    func isStopped() -> Bool {
        return state == OVHVPSState.stopped.rawValue
    }
    
    func isStateUnknown() -> Bool {
        return state == OVHVPSState.unknown.rawValue
    }

    func watchRepresentation() -> [String:AnyObject] {
        var representation = [String:AnyObject]()
        
        if let name = name {
            representation["name"] = name
        }
        if let displayName = displayName {
            representation["displayName"] = displayName
        }
        if let state = state {
            representation["state"] = state
        }
        
        representation["busy"] = isBusy()
        
        return representation
    }
}

public enum OVHVPSState : String {
    case installing, maintenance, rebooting, running, stopped, stopping, upgrading, unknown
}