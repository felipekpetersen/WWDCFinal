import Foundation
import UIKit

class CVCCell: UICollectionViewCell {
    
    let view = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8.0
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "nose")
        view.addSubview(imageView)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: String){
        imageView.image = UIImage(named: image)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame.size = CGSize(width: bounds.width-20, height: bounds.height-20)
        imageView.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: bounds.height - 20)
        print(view.center)
        setBlur()
        
        
        view.frame = bounds
    }
    
    func setBlur() {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 8.0
            blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        self.view.sendSubviewToBack(blurEffectView)
    }
    
}

protocol SelectionCollectionViewControllerDelegate {
    func didChose(image: String)
}

public class SelectionCollectionViewController: UICollectionViewController {

    var images = [String]()

    let spacing: CGFloat = 15
    let size: CGFloat = 120
    var delegate: SelectionCollectionViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print(self.images)
        self.collectionView?.register(CVCCell.self, forCellWithReuseIdentifier: "ItensCell")
        setupColors()
        addDismissTap()
    }
    
    func setupColors() {
        self.view.backgroundColor = .clear
        self.collectionView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.view.isOpaque = false
        self.collectionView?.isOpaque = false
        self.collectionView.backgroundView = UIView.init(frame: CGRect.zero)
    }
    
    func addDismissTap() {
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        dismissTap.cancelsTouchesInView = false
        self.collectionView.addGestureRecognizer(dismissTap)
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SelectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItensCell", for: indexPath) as! CVCCell
        cell.backgroundColor = .clear
        cell.setup(image: images[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:30, left: 30, bottom: 0, right: 30)
    }

    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didChose(image: self.images[indexPath.row])
    }
}
