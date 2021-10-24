//
//  SearchResultTableViewCell.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    // MARK: - UIComponents

    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return label
    }()

    var descriptionLabel = UILabel()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .center

        stack.addArrangedSubview(starsLabel)
        stack.addArrangedSubview(languageLabel)
        stack.addArrangedSubview(updatedAtDateLabel)

        return stack
    }()

    var starsLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .white
        label.backgroundColor = .gray
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    var updatedAtDateLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setCell()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setConstraints() {
        [fullNameLabel, descriptionLabel, stackView].forEach { contentView.addSubview($0) }

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(fullNameLabel)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(fullNameLabel)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func setCell() {
        fullNameLabel.text = "github/repository"
        descriptionLabel.text = "repository desc"
        starsLabel.text = "✩ 13"
        languageLabel.text = "Swift"
        updatedAtDateLabel.text = "updated on 20 Sep 2021"
    }
}
