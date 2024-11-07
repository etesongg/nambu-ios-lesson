//
//  TableView.swift
//  SwiftUi-Uiket
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI
import UIKit

struct TableView:UIViewRepresentable {
    func makeUIView(context: Context) -> UITableView {
        UITableView()
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        uiView.dataSource = context.coordinator
    }
    
    func makeCoordinator() -> TableViewCoordinator {
        TableViewCoordinator()
    }
}

class TableViewCoordinator: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "\(indexPath.row)번째 Row"
        cell.contentConfiguration = config
        return cell
    }
}

#Preview {
    TableView()
}
