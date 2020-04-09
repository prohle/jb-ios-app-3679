//
//  DealDataJson.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
func loadJson(filename fileName: String) -> [Deal]? {
        if let url = Bundle.main.url(forAuxiliaryExecutable: fileName) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let allDeals = try decoder.decode([Deal].self, from: data)
                return allDeals
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
