//
//  ViewController.swift
//  Slider
//
//  Created by Egor Mezhin on 07.07.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var animationBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var squareView: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: CustomSlider = {
       let slider = CustomSlider()
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.delegate = self
        setupAnimator()
        setupView()
    }
}

//MARK: Private methods
extension ViewController {
    private func setupView() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews(){
        view.addSubview(containerView)
        containerView.addSubview(animationBackgroundView)
        containerView.addSubview(slider)
        animationBackgroundView.addSubview(squareView)
    }

    private func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { [unowned self, squareView] in
            squareView.center.x = self.containerView.frame.width - (squareView.frame.width / 2) * 1.5
            squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            
            animationBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            animationBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            animationBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            animationBackgroundView.heightAnchor.constraint(equalToConstant: 200),
            
            slider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            slider.topAnchor.constraint(equalTo: animationBackgroundView.bottomAnchor, constant: 10),
            
            squareView.centerYAnchor.constraint(equalTo: animationBackgroundView.centerYAnchor),
            squareView.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc
    private func sliderValueDidChange(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
}

//MARK: CustomSliderDelegate
extension ViewController: CustomSliderDelegate {
    func sliderFinishedEditing() {
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
        animator.pausesOnCompletion = true
    }
}
