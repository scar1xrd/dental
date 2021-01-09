//
//  DentistTimetableViewController.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class DentistTimetableViewController: BaseViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: DentistTimetableViewModel!
    
    // MARK: UI
    private(set) weak var collectionView: UICollectionView!
    private weak var blurEffectView: UIVisualEffectView!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        let view = DentistTimetableView()
        self.view = view
        collectionView = view.collectionView
        blurEffectView = view.blurEffectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
}

// MARK: - VIEW MODEL INJECTABLE

extension DentistTimetableViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? DentistTimetableViewModel
    }
}

// MARK: - CONFIGURABLE PROVIDER

extension DentistTimetableViewController: ConfigurableProvider {
    var configurable: Configurable? { viewModel }
}

// MARK: - CONFIGURATIONS

private extension DentistTimetableViewController {
    func configure() {
        configureViews()
        setupBindings()
        configureHandlers()
    }
    
    func configureViews() {
        collectionView.register(cellClass: TimeCollectionViewCell.self)
        collectionView.registerSupplementaryView(
            view: DateCollectionReusableView.self,
            kind: UICollectionView.elementKindSectionHeader
        )
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupBindings() {
        viewModel.dentistTimetable
            .subscribe(onNext: { [unowned self] (_) in
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func configureHandlers() {
        viewModel.loadDentistTimetable?
            .onExecuting(
                executingAction: { [unowned self] in
                    self.showHUD()
                }, nonExecutingAction: { [unowned self] in
                    self.hideHUD()
                }
            )
            .disposed(by: disposeBag)
        
        viewModel.loadDentistTimetable?
            .onApiErrors { [unowned self] in
                self.showAlert(title: $0.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Data Source

extension DentistTimetableViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dentistTimetable.value?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.dentistTimetable.value?[section].originalTime.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: TimeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let time = viewModel.dentistTimetable.value?[indexPath.section].originalTime[indexPath.row].timeDisplay
        cell.timeLabel.text = time
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        let view: DateCollectionReusableView = collectionView.dequeueSupplementaryView(
            kind: kind,
            for: indexPath
        )
        
        let date = viewModel.dentistTimetable.value?[indexPath.section].originalTime.first?.dayDisplay
        view.dateLabel.text = date
        
        return view
    }
    
}

// MARK: Delegate & FlowLayout

extension DentistTimetableViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 75)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 70, height: 40)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        12.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let date = viewModel.dentistTimetable.value?[indexPath.section].originalTime[indexPath.row]
        viewModel.selectedDate.accept(date?.id)
    }
    
}
