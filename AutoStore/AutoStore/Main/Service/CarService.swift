//
//  CarService.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 01.03.2026.
//

import Foundation

protocol CarServiceProtocol: AnyObject {
    func fetchDealers() async throws -> [DealerResponse]
}

final class CarService: CarServiceProtocol {
    func fetchDealers() async throws -> [DealerResponse] {
        return [
            DealerResponse(id: 1, name: "Geely Auto Center", cars: fetchCarsPage1()),
            DealerResponse(id: 2, name: "BMW Premium Selection", cars: fetchCarsPage2()),
            DealerResponse(id: 3, name: "Mercedes-Benz Center", cars: fetchCarsPage3())
//            DealerResponse(id: 4, name: "Audi Center"),
//            DealerResponse(id: 5, name: "Toyota Center Almaty"),
//            DealerResponse(id: 6, name: "Lexus Almaty")
        ]
    }
    
    private func fetchCarsPage1() -> [CarResponse] {
        [
            CarResponse(
                id: 1,
                name: "Geely Coolray 1",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 2,
                name: "Geely Coolray 2",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 3,
                name: "Geely Coolray 3",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 4,
                name: "Geely Coolray 4",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 5,
                name: "Geely Coolray 5",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 6,
                name: "Geely Coolray 6",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 7,
                name: "Geely Coolray 7",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 8,
                name: "Geely Coolray 8",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 9,
                name:  "Geely Coolray 9",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 10,
                name: "Geely Coolray 10",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            )
        ]
    }
    
    private func fetchCarsPage2() -> [CarResponse] {
        [
            CarResponse(
                id: 11,
                name: "Geely Coolray 11",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 12,
                name: "Geely Coolray 12",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 13,
                name:  "Geely Coolray 13",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 14,
                name:  "Geely Coolray 14",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 15,
                name:  "Geely Coolray 15",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 16,
                name: "Geely Coolray 16",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 17,
                name: "Geely Coolray 17",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 18,
                name: "Geely Coolray 18",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 19,
                name: "Geely Coolray 19",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 20,
                name: "Geely Coolray 20",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            )
        ]
    }
    
    private func fetchCarsPage3() -> [CarResponse] {
        [
            CarResponse(
                id: 21,
                name: "Geely Coolray 11",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 22,
                name: "Geely Coolray 12",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 23,
                name:  "Geely Coolray 13",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 24,
                name:  "Geely Coolray 14",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 25,
                name:  "Geely Coolray 15",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 26,
                name: "Geely Coolray 16",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 27,
                name: "Geely Coolray 17",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            ),
            CarResponse(
                id: 28,
                name: "Geely Coolray 18",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt-zdD-aU-cl9reRPbCl5a3K3YzX1ObsmJlg&s"
            ),
            CarResponse(
                id: 29,
                name: "Geely Coolray 19",
                imageUrl: "https://www.new-energy-vehicles.ru/uploads/40938/geely-coolray-2024-1-5t-dct-longteng-editione655a.jpg"
            ),
            CarResponse(
                id: 30,
                name: "Geely Coolray 20",
                imageUrl: "https://strg1.nm.kz/neofiles/serve-image/64b504705e89410007559de0/1190x500/q90"
            )
        ]
    }
}
