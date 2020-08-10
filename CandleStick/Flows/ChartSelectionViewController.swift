//
//  ChartSelectionViewController.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import UIKit

enum ChartDataType: CaseIterable {
    case hourly
    case daily
    
    var title: String {
        switch self {
        case .hourly:
            return "Hourly data"
        case .daily:
            return "Daily data"
        }
    }
}

class ChartSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     Interview Task:
     
     - Please build an app in SWIFT that can parse the files (attached) and draw a chart that compares performance of 3 stocks (AAPL, MSFT and SPY) for the last week (Hourly data) and last month (Daily data) based on Open or Close data
     
     Bonus: Draw a candlestick chart for any of the stocks that we provided data for (AAPL, MSFT and SPY). Learn more here https://www.investopedia.com/trading/candlestick-charting-what-is-it/
     
     Hint:
     -How to calculate performance and compare:
     Let's say for stock XYZ, the first day price is 100, and the second day price is 120 and third day price is 110. So the performance data would be 0%, 20% ,10%. And you can calculate the same way for SPY and return both values as an array/list (with the timestamp of each datapoint) through REST API.
     
     Please create a brief 1-min video to explain the code and chart. doesn't need to be professional. Upload it on Google drive or other file sharing service and share the link.
     
     Note: Please kindly do not send me zip files over email. Kindly upload the code in your personal github or and repo and share the link with me.
     
     
     Understanding a Candlestick Chart
     https://www.investopedia.com
     
     */
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var screens: [ChartDataType] = ChartDataType.allCases
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Select chart data"
        setupTableView()
    }
    
    // MARK: - Setup UI
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = screens[indexPath.row].title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewContoller: ChartDataViewController = ChartDataViewController.initWithNib()
        let chartDataType: ChartDataType
        
        switch screens[indexPath.row] {
        case .daily:
            chartDataType = .daily
        case .hourly:
            chartDataType = .hourly
        }
        
        viewContoller.viewModel = ChartDataViewModel(screen: chartDataType)
        self.navigationController?.pushViewController(viewContoller, animated: true)
    }
}
