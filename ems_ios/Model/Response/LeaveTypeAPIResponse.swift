//
//  LeaveTypeAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//
struct LeaveTypeAPIResponse: Decodable{
    let data: LeaveTypeAPIResponseData
}

struct LeaveTypeAPIResponseData: Decodable{
    let list: [LeaveType]
}

