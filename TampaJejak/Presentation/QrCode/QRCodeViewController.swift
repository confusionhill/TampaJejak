//
//  QRCodeViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class QRCodeViewController: UIViewController {
    var qrCodeService: QRCodeService? = QRCodeService()
    
    var QRImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "loading.."
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "loading.."
        return label
    }()
    
    override func loadView() {
        super.loadView()
        qrCodeService?.generateQRCode(message: "message", completion: { res in
            switch res {
            case .success(let img):
                self.QRImageView.image = img
            case .failure(let e):
                print(e.localizedDescription)
            }
        })
        QRImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(QRImageView)
        view.addSubview(codeLabel)
        view.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            
            //QRImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            QRImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            QRImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor,constant: 30),
            QRImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QRImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            QRImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            codeLabel.topAnchor.constraint(equalTo: QRImageView.bottomAnchor,constant: 20),
            codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            priceLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor,constant: 10)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
