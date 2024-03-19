//
//  LanguageView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 18/3/24.
//

import UIKit

enum Language {
    case kyrgyz
    case russian
    case english
}
struct LanguageText {
    let language: Language
}
class LanguageView: UIViewController {

    private let setData: [FillLanguage] = [FillLanguage(image: "kyrgyzLanguage_icon", 
                                                        language: "Кыргызча"),
                                           FillLanguage(image: "russianLanguage_icon",
                                                        language: "Русский"),
                                           FillLanguage(image: "englishLanguage_icon",
                                                        language: "English")]
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.text = "Выберите язык"
        view.textColor = .label
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
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview().offset(4)
            make.height.equalTo(42)
            make.width.equalTo(153)
        }
        view.addSubview(languageTableView)
        languageTableView.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(151)
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
}
