//
//  PasswordLevel.swift
//  LoginDemo
//
//  Created by MingXin Liu on 2023/7/8.
//

import Foundation

enum PasswordLevel {
    case weak, average, strong, secure
    
    static func calculatePasswordLevel(password: String) -> PasswordLevel {
        let score = calculateScore(password: password)
        let level: PasswordLevel
        if score >= 80 {
            level = .secure
        } else if score >= 60 {
            level = .strong
        } else if score >= 50 {
            level = .average
        } else {
            level = .weak
        }
        return level
    }
    
    static private func calculateScore(password: String) -> Int {
        let count = password.count
        guard count > 5 else {
            return 0
        }
        let array = Array(password)
        var aCount = 0
        var ACount = 0
        var numCount = 0
        var otherCount = 0
        var score = 0
         
        array.forEach { c in
            if (c >= "a" && c <= "z") {
                aCount += 1
            } else if c >= "A" && c <= "Z" {
                ACount += 1
            } else if  c >= "0" && c <= "9" {
                numCount += 1
            } else {
                otherCount += 1
            }
        }
         
        if aCount == 0 && ACount == 0 {
            score += 0
        } else if aCount != 0 && ACount == 0 {
            score += 10
        } else if ACount != 0 && aCount == 0 {
            score += 10
        } else if ACount != 0 && aCount != 0 {
            score += 20
        }
         
        if count >= 5 && count <= 7 {
            score += 10
        } else if count >= 8 {
            score += 25
        }
         
        if numCount == 0 {
            score += 0
        } else if numCount == 1 {
            score += 10
        } else if numCount > 1 {
            score += 20
        }
         
        if otherCount == 0 {
            score += 0
        } else if otherCount == 1 {
            score += 10
        } else if otherCount > 1 {
            score += 25
        }
         
        if aCount + ACount > 0 && numCount > 0  && otherCount == 0 {
            score += 2
        } else if (aCount == 0 || ACount == 0) && numCount > 0 && otherCount > 0 {
            score += 3
        } else if aCount > 0 && ACount > 0 && numCount > 0 && otherCount > 0 {
            score += 5
        }
        return score
    }
    
}
