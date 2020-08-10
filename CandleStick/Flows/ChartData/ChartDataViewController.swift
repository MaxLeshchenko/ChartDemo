//
//  ChartDataViewController.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import UIKit
import Charts

class ChartDataViewController: UIViewController, ChartViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var chartDataTitleLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var AAPLCandleStickChartView: CandleStickChartView!
    @IBOutlet weak var MSFTCandleStickChartView: CandleStickChartView!
    @IBOutlet weak var SPYCandleStickChartView: CandleStickChartView!
    
    // MARK: - Properties
    var viewModel: ChartDataViewModel?
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchQuotes()
    }
    
    // MARK: - Fetch request
    private func fetchQuotes() {
        viewModel?.fetchQuotes(successCompletion: { [weak self] (quotes) in
            guard let self = self else { return }
            
            self.configureLineChartData(for: self.lineChartView, with: quotes)
            self.configureCandleStickChartData(for: self.AAPLCandleStickChartView, quote: quotes[0])
            self.configureCandleStickChartData(for: self.MSFTCandleStickChartView, quote: quotes[1])
            self.configureCandleStickChartData(for: self.SPYCandleStickChartView, quote: quotes[2])
            
        }) { (message) in
            print(message)
        }
    }
    
    // MARK: - Configuration
    private func setupUI() {
        chartDataTitleLabel.text = viewModel?.title
        
        configureLineChartView(lineChartView)
        configureCandleStickChartView(AAPLCandleStickChartView)
        configureCandleStickChartView(MSFTCandleStickChartView)
        configureCandleStickChartView(SPYCandleStickChartView)
    }
    
    private func configureCandleStickChartView(_ chartView: CandleStickChartView) {
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 500
        chartView.pinchZoomEnabled = true
        
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
    }
    
    private func configureLineChartView(_ chartView: LineChartView) {
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.drawBordersEnabled = false
        chartView.setScaleEnabled(true)

        let legend = chartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = false
    }
    
    func configureLineChartData(for chartView: LineChartView, with qoutes: [QuoteSymbol]) {
        
        let calculator = PerformanceCalculator()
                
        let colors = ChartColorTemplates.vordiplom()
        let dataSets = qoutes.enumerated().map { (index, quote) -> LineChartDataSet in
            
            let performance = calculator.calculate(for: quote)
            let dataEntry = performance.map({  ChartDataEntry(x: Double($0.timestamp), y: $0.performance) })
                       
            let set = LineChartDataSet(entries: dataEntry, label: quote.symbol)
            set.lineWidth = 2.5
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = colors[index % colors.count]
            set.setColor(color)
            set.setCircleColor(color)
            
            return set
        }
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        chartView.data = data
    }
    
    func configureCandleStickChartData(for chartView: CandleStickChartView, quote: QuoteSymbol) {
        
        var dataEntries: [CandleChartDataEntry] = []
        
        for (index, _) in quote.timestamps.enumerated() {
            
            let high = quote.highs[index]
            let low = quote.lows[index]
            let open = quote.opens[index]
            let close = quote.closures[index]
            
            let chartDataEntry = CandleChartDataEntry(x: Double(index),
                                                      shadowH: high,
                                                      shadowL: low,
                                                      open: open,
                                                      close: close,
                                                      icon: nil)
            
            dataEntries.append(chartDataEntry)
        }
        
        
        
        let set1 = CandleChartDataSet(entries: dataEntries, label: quote.symbol)
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = false
        set1.neutralColor = .blue
        
        let data = CandleChartData(dataSet: set1)
        chartView.data = data
    }

}

