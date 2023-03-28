//
//  ViewController.swift
//  CoreMLTestApp
//
//  Created by demasek on 27.03.2023.
//

import UIKit
import CoreML
import PhotoEditorSDK
import AVFoundation

class ViewController: UIViewController {
	private lazy var photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var backPhotoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .black
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var editButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .black
		button.setTitle("let's go", for: .normal)
		button.titleLabel?.textColor = .white
		button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
		return button
	}()
	
	let imageArray = [
		UIImage(named: "test_image 1"),
		UIImage(named: "test_image 2"),
		UIImage(named: "test_image 3"),
		UIImage(named: "test_image 4"),
		UIImage(named: "test_image 5"),
		UIImage(named: "test_image 6"),
		UIImage(named: "test_image 7"),
		UIImage(named: "test_image 8")
	]
	
	let imageArrayWithoutBackground = [
		UIImage(named: "test_image 1")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 2")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 3")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 4")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 5")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 6")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 7")?.removeBackground(returnResult: .finalImage),
		UIImage(named: "test_image 8")?.removeBackground(returnResult: .finalImage)
	]
	
	var player: AVAudioPlayer!

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupViews()
		setConstraints()
	}
	
	private func setupViews() {
		view.addSubview(backPhotoImageView)
		view.addSubview(photoImageView)
		view.addSubview(editButton)
	}
	
	var i = 0
	
	@objc
	private func editButtonTapped() {
		if i == 0 {
			playSound()
			backPhotoImageView.image = imageArray[i]
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.photoImageView.image = self.imageArrayWithoutBackground[self.i]
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.photoImageView.image = self.imageArray[self.i]
			self.backPhotoImageView.image = self.imageArray[self.i]
			self.i += 1
			if self.i < self.imageArray.count {
				self.editButtonTapped()
			} else {
				self.i = 0
				self.photoImageView.image = nil
				self.backPhotoImageView.image = nil
				self.stopSound()
			}
		}
	}
	
	func playSound() {
		let url = Bundle.main.url(forResource: "music", withExtension: "aac")
		player = try! AVAudioPlayer(contentsOf: url!)
		player.play()
	}
	
	func stopSound() {
		player.stop()
	}
	
	private func setConstraints() {
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
			photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		backPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			backPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			backPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backPhotoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
			backPhotoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		editButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			editButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
			editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

