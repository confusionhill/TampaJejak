//
//  PickerDisplayViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

protocol PickerDisplayDelegate: AnyObject {
    func didFinnishPickItem(name: String)
    func didTapClosePicker()
}

class PickerDisplayViewController: UIViewController {
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setRounded()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .primarygreen
        return button
    }()
    
    // any enum that that inherit the CaseIterable protocol
    var data: [String] = []
    
    weak var output: PickerDisplayDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.dataSource = self
        self.picker.delegate = self
        self.view.addSubview(picker)
        self.view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: view.topAnchor,constant: 10),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor ,constant: -40),
            doneButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 307),
            doneButton.heightAnchor.constraint(equalToConstant: 53),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 34),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            picker.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: -10)
        ])
        
        self.doneButton.addTarget(self, action: #selector(self.didTapDone), for: .touchUpInside)
    }
    
    @objc func didTapDone() {
        self.output?.didTapClosePicker()
    }

}

extension PickerDisplayViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.output?.didFinnishPickItem(name: data[row])
    }
}

extension PickerDisplayViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
}
