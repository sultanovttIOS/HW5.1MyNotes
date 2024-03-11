//
//  AddNotesView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 9/3/24.
//

import UIKit

class AddNotesView: UIViewController {
    
    //var notes: NoteCell?
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        let viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 4))
        view.leftViewMode = .always
        view.leftView = viewLeft
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private lazy var notesTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "CustomTextViewColor")
        view.textColor = UIColor(named: "CustomTextColor")
        view.isScrollEnabled = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "copy_icon"), for: .normal)
        view.tintColor = .lightGray
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return  view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Сохранить", for: .normal)
        view.backgroundColor = UIColor(named: "CustomRed")
        view.layer.cornerRadius = 23
        view.tintColor = .white
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarItem()
        
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupNavBarItem() {
        navigationItem.title = "Note"
        
        let customButton = UIButton(type: .system)
        let image = UIImage(named: "settings_icon")
        let desiredSize = CGSize(width: 25, height: 25)
        let scaledImage = image?.resized(to: desiredSize)
        customButton.setImage(scaledImage, for: .normal)
        customButton.tintColor = .black
        customButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        if UserDefaults.standard.bool(forKey: "theme") == true {
            customButton.tintColor = .white
        } else {
            customButton.tintColor = .black
        }
        let rightBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func settingsButtonTapped() {
        
    }
    
    private func setupConstraints() {
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(34)
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.width.equalTo(347)
            make.height.equalTo(42)
        }
        view.addSubview(notesTextView)
        notesTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(saveButton.snp.top).offset(-105)
        }
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.bottom.equalTo(saveButton.snp.top).offset(-117)
            make.trailing.equalToSuperview().offset(-35)
            make.height.width.equalTo(32)
        }
    }
    @objc func copyButtonTapped() {
        guard let textToCopy = notesTextView.text else { return }
        
        UIPasteboard.general.string = textToCopy
    }
}
