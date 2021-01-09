//
//  GenericTableViewCell.swift
//  Dental
//
//  Created by Igor Sorokin on 01.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class GenericTableViewCell<View: UIView & CellView>: UITableViewCell {
    private(set) weak var view: View!
    
    func setup(view: View) {
        self.view = view
        contentView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        view.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        view.setHighlighted(highlighted, animated: animated)
    }
    
}
