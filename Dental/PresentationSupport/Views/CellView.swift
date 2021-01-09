//
//  CellView.swift
//  Dental
//
//  Created by Igor Sorokin on 19.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

protocol CellView: class {
    func prepareForReuse()
    func setSelected(_ selected: Bool, animated: Bool)
    func setHighlighted(_ highlighted: Bool, animated: Bool)
    func size(for prefferedSize: CGSize) -> CGSize
}

extension CellView {
    func prepareForReuse() {}
    func setSelected(_ selected: Bool, animated: Bool) {}
    func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    func size(for prefferedSize: CGSize) -> CGSize {
        return prefferedSize
    }
}
