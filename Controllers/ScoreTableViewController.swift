//
//  ScoreTableViewController.swift
//  QuizApp
//
//  Created by User on 20/02/25.
//

import UIKit
import DGCharts  // Import Charts library

class ScoreTableViewController: UITableViewController {
    
    var scores: [Int] = [8,9,6,5,4,2]
    let maxScore = 50  // Assume the maximum possible score is 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve previous scores from UserDefaults and sort them in descending order
     //   scores = UserDefaults.standard.array(forKey: "quizScores") as? [Int] ?? []
     //   scores.sort(by: >) // Sorting in descending order (highest score first)
        
        // Register the custom cell
        tableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        let score = scores[indexPath.row]
        cell.configure(with: score, maxScore: maxScore, index: indexPath.row) // Pass index
        return cell
    }
    
    

}

// MARK: - Custom UITableViewCell with Bar Chart
class ScoreCell: UITableViewCell {
    
    var barChartView: HorizontalBarChartView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBarChartView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBarChartView()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false) // Prevent selection color change
    }

    
    private func setupBarChartView() {
        barChartView = HorizontalBarChartView()
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(barChartView)
        
        // Constraints to make the chart fit nicely inside the cell
        NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            barChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            barChartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            barChartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            barChartView.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
    }
    func configure(with score: Int, maxScore: Int, index: Int) {
        // Normalize the score to scale between 0 and maxScore
        let normalizedScore = Double(score) / Double(maxScore)

        let entry = BarChartDataEntry(x: Double(index), y: normalizedScore * 10) // Scale for better visibility

        let dataSet = BarChartDataSet(entries: [entry], label: "")

        // Change bar color based on score
        if score >= Int(Double(maxScore) * 0.8) {
            dataSet.colors = [UIColor.systemGreen] // High score = Green
        } else if score >= Int(Double(maxScore) * 0.5) {
            dataSet.colors = [UIColor.systemOrange] // Medium score = Orange
        } else {
            dataSet.colors = [UIColor.systemRed] // Low score = Red
        }

        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.7 // Adjust bar width

        barChartView.data = data

        // Customize appearance
        barChartView.legend.enabled = false
        barChartView.xAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.fitBars = true

        // Make the animation smoother
        barChartView.animate(yAxisDuration: 1.5, easingOption: .easeOutBounce)

        // Add a label to show the score beside the bar
        let scoreLabel = UILabel()
        scoreLabel.text = "\(score)"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scoreLabel.textAlignment = .left
        contentView.addSubview(scoreLabel)

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
