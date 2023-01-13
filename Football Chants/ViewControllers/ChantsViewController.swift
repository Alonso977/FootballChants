//
//  ChantsViewController.swift
//  Football Chants
//
//  Created by Alonso Alas on 4/1/23.
//

import UIKit

class ChantsViewController: UIViewController {
    
    // Alonso: -  UI
    
    private lazy var tableVw: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor(named: "bg")
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.identifier)
        return tv
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    private lazy var audioManagerViewModel = AudioManagerViewModel()
    
    // Alonso: - LifeCycle
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: "bg")
    }
}

private extension ChantsViewController {
    func setup() {
        
        self.navigationController?.navigationBar.topItem?.title = "Football Chants"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        
        tableVw.dataSource = self
        
        self.view.addSubview(tableVw)
        
        NSLayoutConstraint.activate([
            tableVw.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableVw.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableVw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableVw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
}

extension ChantsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as! TeamTableViewCell
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.configure(with: team, delegate: self)
        
        return cell
        
    }
    
}

extension ChantsViewController: TeamTableViewCellDelegate{
    func didTapPlayBack(for team: Team) {
        audioManagerViewModel.playback(team)
        teamsViewModel.togglePlayBack(for: team)
        tableVw.reloadData()
    }
}

