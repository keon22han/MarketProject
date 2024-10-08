//
//  HeaderCell.swift
//  MarketProject
//
//  Created by 한건희 on 8/21/24.
//

import Foundation
import UIKit
import Then
import SnapKit

final class HeaderCell: UICollectionViewCell {
    // MARK: Constants
    static let id = "HeaderCell"
    
    // MARK: UIs
    fileprivate let titleButton = UIButton().then {
        $0.setTitleColor(.lightGray, for: .normal)
        $0.setTitleColor(.black, for: .highlighted)
        $0.setTitleColor(.black, for: .selected)
    }
    
    // MARK: Properties
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Initializers
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayouts()
    }
    
    // MARK: Methods
    private func setupLayouts() {
        contentView.addSubview(titleButton)
        
        titleButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        rx.prepare.onNext(nil)
    }
}

extension Reactive where Base: HeaderCell {
    var prepare: Binder<HeaderItemType?> {
        Binder(base) { base, itemType in
            base.titleButton.setTitle(itemType?.title, for: .normal)
            base.titleButton.setTitle(itemType?.title, for: .selected)
            base.titleButton.isSelected = itemType?.isSelected ?? false
        }
    }
    
    var onTap: Observable<Void> {
        base.titleButton.rx.tap.mapTo(()).asObservable()
    }
}
