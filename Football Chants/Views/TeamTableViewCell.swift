//
//  TeamTableViewCell.swift
//  Football Chants
//
//  Created by Alonso Alas on 7/1/23.
//

import UIKit

protocol TeamTableViewCellDelegate: class {
    func didTapPlayBack(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    
    static let identifier = "TeamTableViewCell"
    
    // Alonso: - UI
    
    private lazy var containerView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "bg")
        return vw
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var badgeImage:UIImageView = {
        let imageVw = UIImageView()
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        imageVw.contentMode = .scaleAspectFit
        return imageVw
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var nameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.numberOfLines = 0
        nameLbl.font = .systemFont(ofSize: 18, weight: .bold)
        nameLbl.textColor = .white
        return nameLbl
    }()
    
    private lazy var foundedLbl: UILabel = {
        let fLbl = UILabel()
        fLbl.translatesAutoresizingMaskIntoConstraints = false
        fLbl.numberOfLines = 0
        fLbl.font = .systemFont(ofSize: 12, weight: .light)
        fLbl.textColor = .white
        return fLbl
    }()
    
    private lazy var jobLbl: UILabel = {
        let jLbl = UILabel()
        jLbl.translatesAutoresizingMaskIntoConstraints = false
        jLbl.numberOfLines = 0
        jLbl.font = .systemFont(ofSize: 10, weight: .light)
        jLbl.textColor = .white
        return jLbl
    }()
    
    private lazy var infoLbl: UILabel = {
        let infoLbl = UILabel()
        infoLbl.translatesAutoresizingMaskIntoConstraints = false
        infoLbl.numberOfLines = 0
        infoLbl.font = .systemFont(ofSize: 12, weight: .medium)
        infoLbl.textColor = .white
        return infoLbl
    }()
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    // Alonso: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 5
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.contentView.subviews.forEach {$0.removeFromSuperview()}
    }
    
    func configure(with item: Team, delegate: TeamTableViewCellDelegate){
        self.team = item
        self.delegate = delegate
        
        playBtn.addTarget(self, action: #selector(didTapPlayBack), for: .touchUpInside)
        
        containerView.backgroundColor = item.id.background
        
        badgeImage.image = item.id.badge
        playBtn.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        
        nameLbl.text = item.name
        foundedLbl.text = item.founded
        jobLbl.text = "Current \(item.manager.job.rawValue): \(item.manager.name)"
        infoLbl.text = item.info
        
        self.contentView.addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        containerView.addSubview(badgeImage)
        containerView.addSubview(playBtn)
        
        contentStackView.addArrangedSubview(nameLbl)
        contentStackView.addArrangedSubview(foundedLbl)
        contentStackView.addArrangedSubview(jobLbl)
        contentStackView.addArrangedSubview(infoLbl)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImage.heightAnchor.constraint(equalToConstant: 50),
            badgeImage.widthAnchor.constraint(equalToConstant: 50),
            badgeImage.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            badgeImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: badgeImage.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: playBtn.leadingAnchor, constant: -8),
            
            playBtn.heightAnchor.constraint(equalToConstant: 44),
            playBtn.widthAnchor.constraint(equalToConstant: 44),
            playBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    @objc func didTapPlayBack(){
        if let team = team {
            delegate?.didTapPlayBack(for: team)
        }
        
    }
}
