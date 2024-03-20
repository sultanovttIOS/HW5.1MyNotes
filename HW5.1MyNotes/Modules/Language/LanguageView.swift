//
//  LanguageView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 18/3/24.
//

import UIKit

protocol LanguageViewProtocol: AnyObject {
    func didChangeLanguage(languageType: LanguageType)
}
class LanguageView: UIViewController {
    
    weak var delegate: LanguageViewProtocol?

    private let setData: [FillLanguage] = [FillLanguage(image: "kyrgyzLanguage_icon", 
                                                        language: "Кыргызча"),
                                           FillLanguage(image: "russianLanguage_icon",
                                                        language: "Русский"),
                                           FillLanguage(image: "englishLanguage_icon",
                                                        language: "English")]
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.text = "Choose language".localized()
        view.textColor = .label
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 17)
        return view
    }()
    
    private lazy var languageTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        view.isScrollEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    private func setupConstraints() {
        view.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(4)
            make.height.equalTo(42)
            make.width.equalTo(153)
        }
        view.addSubview(languageTableView)
        languageTableView.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(150)
            languageTableView.layer.cornerRadius = 10
        }
    }
}

extension LanguageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        cell.fill(with: setData[indexPath.row])
        return cell
    }
}
extension LanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppLanguageManager.shared.setAppLanguage(language: .kg)
            delegate?.didChangeLanguage(languageType: .kg)
        case 1:
            AppLanguageManager.shared.setAppLanguage(language: .ru)
            delegate?.didChangeLanguage(languageType: .ru)
        case 2:
            AppLanguageManager.shared.setAppLanguage(language: .en)
            delegate?.didChangeLanguage(languageType: .en)
        default:
            ()
        }
        dismiss(animated: true)
    }
}
