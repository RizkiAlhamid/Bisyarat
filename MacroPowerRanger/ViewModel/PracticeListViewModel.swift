//
//  PracticeListViewModel.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import Foundation
import SwiftUI

class PracticeListViewModel: ObservableObject
{
    @Published var practices = [Practice]()
    
    init(){
        fetchPractices()
    }
    
    func fetchPractices(){
        practices = PracticeSampleData.practices
    }
}
