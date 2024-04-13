//
//  ViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func successNotes(notes: [Note] )
}

class HomeView: UIViewController {
    private var controller: HomeControllerProtocol?
    private var notes: [Note] = []
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.layer.cornerRadius = 10
        view.searchTextField.addTarget(self, action: #selector(notesSearchBarEditingChanged), 
                                       for: .editingChanged)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var addButton = MakerView.shared.makerButton(title: "+",
                                                              backgroundColor: UIColor(named: "CustomRed")!,
                                                              cornerRadius: 42 / 2,
                                                              tintColor: .white)
    deinit {
        print("Экран HomeView уничтожился с памяти!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
        controller = HomeController(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.placeholder = "Search".localized()
        titleLabel.text = "Notes".localized()
        navigationItem.hidesBackButton = true
        setupNavigationItem()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        controller?.onGetNotes()
    }
    
    private func setupNavigationItem() {
        let titleText = UILabel()
        titleText.text = "Home".localized()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            titleText.textColor = .white
        } else {
            titleText.textColor = .black
        }
        navigationItem.titleView = titleText

        let customButton = UIButton(type: .system)
        let image = UIImage(named: "settings_icon")
        let desiredSize = CGSize(width: 25, height: 25)
        let scaledImage = image?.resized(to: desiredSize)
        customButton.setImage(scaledImage, for: .normal)
        customButton.tintColor = .black
        customButton.addTarget(self, action: #selector(settingsButtonTapped),
                               for: .touchUpInside)
        
        if UserDefaults.standard.bool(forKey: "theme") == true {
            customButton.tintColor = .white
        } else {
            customButton.tintColor = .black
        }
        let rightBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func settingsButtonTapped() {
        let sv = SettingsView()
        navigationController?.pushViewController(sv, animated: true)
    }
    @objc func notesSearchBarEditingChanged() {
        controller?.onNoteSearching(text: searchBar.text ?? "")
    }
    @objc func addNotesButtonTapped() {
        let noteView = NoteView()
        navigationController?.pushViewController(noteView, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.leading.equalTo(39)
            make.height.equalTo(42)
        }
        view.addSubview(notesCollectionView)
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.snp.bottom)
        }
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-133)
            make.height.width.equalTo(42)
            make.centerX.equalTo(view.snp.centerX)
            
            addButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            addButton.addTarget(self, action: #selector(addNotesButtonTapped), for: .touchUpInside)
        }
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let newNoteView = NoteView()
        newNoteView.note = notes[indexPath.row]
        navigationController?.pushViewController(newNoteView, animated: true)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, 
                                                      for: indexPath) as! NoteCell
        cell.fill(title: notes[indexPath.row].title ?? "" )
        return cell
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Note]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
}
