//
//  AddNotesView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 9/3/24.
//

import UIKit

protocol NoteViewProtocol {
    func successAddNote()
    func failureAddNote()
    func successDelete()
    func failureDelete()
    func successUpdateNote()
}

class NoteView: UIViewController {
    private let coreDataService = CoreDataService.shared
    
    var note: Note?
    
    var controller: NoteControllerProtocol?
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Title".localized()
        let viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 4))
        view.leftViewMode = .always
        view.leftView = viewLeft
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 0.5
        view.addTarget(self, action: #selector(textFieldEdidtingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var notesTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "CustomTextViewColor")
        view.textColor = UIColor(named: "CustomTextColor")
        view.layer.cornerRadius = 14
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.autocorrectionType = .no
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.delegate = self
        //view.addTarget(self, action: #selector(textFieldEdidtingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "copy_icon"), for: .normal)
        view.tintColor = .lightGray
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return  view
    }()
    
    private lazy var notesDateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .secondaryLabel
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save".localized(), for: .normal)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 23
        view.tintColor = .white
        view.isEnabled = false
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return view
    }()
    
    deinit {
        print("Экран NoteView исчез и удалился с памяти!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
        controller = NoteController(view: self)
        guard let note = note else { return }
        titleTextField.text = note.title
        notesTextView.text = note.desc
        notesDateLabel.text = note.date
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
        let titleText = UILabel()
        titleText.text = "Note".localized()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            titleText.textColor = .white
        } else {
            titleText.textColor = .black
        }
        navigationItem.titleView = titleText
        
        let customLeftButton = UIButton(type: .system)
        customLeftButton.tintColor = .black
        customLeftButton.setTitle("Home".localized(), for: .normal)
        customLeftButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        if UserDefaults.standard.bool(forKey: "theme") == true {
            customLeftButton.tintColor = .white
        } else {
            customLeftButton.tintColor = .black
        }
        let leftBarButton = UIBarButtonItem(customView: customLeftButton)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashButtonTapped))
        if UserDefaults.standard.bool(forKey: "theme") == true {
            rightBarButton.tintColor = .white
        } else {
            rightBarButton.tintColor = .black
        }
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func copyButtonTapped() {
        guard let textToCopy = notesTextView.text else { return }
        
        UIPasteboard.general.string = textToCopy
    }
    
    @objc func textFieldEdidtingChanged() {
        if let titleText = titleTextField.text, let viewText = notesTextView.text {
            if !titleText.isEmpty || !viewText.isEmpty {
                saveButton.isEnabled = true
                saveButton.backgroundColor = UIColor(named: "CustomRed")
            } else {
                saveButton.isEnabled = true
                saveButton.backgroundColor = .lightGray
            }
        }
    }
    
    private func updateSaveButtonState() {
        guard let titleText = titleTextField.text, let viewText = notesTextView.text else {
            return
        }
        if !titleText.isEmpty || !viewText.isEmpty {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor(named: "CustomRed")
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .lightGray
        }
    }
    
    @objc func saveButtonTapped() {
        controller?.onAddNote(note: note, title: titleTextField.text ?? "", description: notesTextView.text)
        successUpdateNote()
    }
    
    @objc func trashButtonTapped() {
        guard let note = note else { return }
        let alert = UIAlertController(title: "Delete".localized(), message: "Delete note?".localized(), preferredStyle: .alert)
        let acceptAlert = UIAlertAction(title: "Yes".localized(), style: .destructive) { action in
            self.controller?.onDeleteNote(id: note.id ?? "")
        }
        let actionDecline = UIAlertAction(title: "No".localized(), style: .cancel)
        alert.addAction(actionDecline)
        alert.addAction(acceptAlert)
        present(alert, animated: true)
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
            make.bottom.equalTo(notesTextView.snp.bottom).offset(-12)
            make.trailing.equalTo(notesTextView.snp.trailing).offset(-15)
            make.height.width.equalTo(32)
        }
        view.addSubview(notesDateLabel)
        notesDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(notesTextView.snp.bottom).offset(-12)
            make.left.equalTo(notesTextView.snp.left).offset(15)
            make.height.equalTo(17)
        }
    }
}

extension NoteView: NoteViewProtocol {
    func successAddNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureAddNote() {
        let alert = UIAlertController(title: "Error".localized(), message: "Failed to delete note!".localized(), preferredStyle: .alert)
        let acceptAlert = UIAlertAction(title: "Back", style: .cancel)
        alert.addAction(acceptAlert)
        present(alert, animated: true)
    }
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    func failureDelete() {
        let alert = UIAlertController(title: "Error".localized(), message: "Failed to delete note!".localized(), preferredStyle: .alert)
        let acceptAlert = UIAlertAction(title: "Back".localized(), style: .destructive)
        alert.addAction(acceptAlert)
        present(alert, animated: true)
    }
    func successUpdateNote() {
        navigationController?.popViewController(animated: true)
    }
}
extension NoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
}
