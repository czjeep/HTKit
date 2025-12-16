//
//  HTFilePickerController.swift
//  HiLeia4.0
//
//  Created by cZ on 2021/7/7.
//  Copyright © 2021 hiscene. All rights reserved.
//

import UIKit
import CoreServices

fileprivate let logTag = "FilePickerController"

protocol HTFilePickerControllerDelegate: NSObjectProtocol {
    
    func didPickFileAt(url: URL)
    
}

class HTFilePickerController: NSObject {
    
    static let shared = HTFilePickerController()
    
    let maxFileSizeMB =  Int(50)
    
    weak var delegage: HTFilePickerControllerDelegate?
    
    /// 显示选择弹窗
    func showAlert(onParent viewController:UIViewController?) {
        parent = viewController
        
        let vc = UIAlertController(title: NSLocalizedString("label_select_file", comment: ""), message: nil, preferredStyle: .alert)
        
        let fileAction = UIAlertAction(title: NSLocalizedString("label_select_from_sys_file", comment: ""), style: .default) { [weak self] _ in
            self?.showFile()
        }
        vc.addAction(fileAction)
        
        let albumAction = UIAlertAction(title: NSLocalizedString("select_from_album", comment: ""), style: .default) { [weak self] _ in
            self?.showAlbum()
        }
        vc.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("button_cancel", comment: ""), style: .cancel, handler: nil)
        vc.addAction(cancelAction)
        
        sender?.present(vc, animated: true, completion: nil)
    }
    
    /// 显示文件
    func showFile() {
        let documentTypes = ["public.content",
                             "public.item",
                             "public.data"]
        let vc = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        if #available(iOS 11.0, *) {
            vc.allowsMultipleSelection = false
        }
        vc.delegate = self
        
        vc.modalPresentationStyle = .fullScreen
        sender?.present(vc, animated: true, completion: nil)
    }
    
    /// 显示图片和视频
    func showAlbum() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        vc.modalPresentationStyle = .fullScreen
        sender?.present(vc, animated: true, completion: nil)
    }
    
    /// 仅显示图片
    func showImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.mediaTypes = [kUTTypeImage as String]
        vc.modalPresentationStyle = .overFullScreen
        sender?.present(vc, animated: true, completion: nil)
    }
    
    /// 拍照。需要配置NSCameraUsageDescription
    func showCamera() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.modalPresentationStyle = .overFullScreen
        sender?.present(vc, animated: true, completion: nil)
    }
    
    private weak var parent: UIViewController?
    var sender: UIViewController? {
        set {
            parent = newValue
        }
        get {
            if let pr = parent {
                return pr
            } else {
                guard let window = UIApplication.shared.keyWindow else {
                    return nil
                }
                let root = window.rootViewController
                if let t = root?.presentedViewController {
                    return t
                }
                return root
            }
        }
    }
    
    @discardableResult
    func setSender(_ vc: UIViewController?) -> Self {
        sender = vc
        return self
    }
    
    private
    func didPickDocumentsAt(urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        let fileSize = getFileSizeOfMB(url: url)
        guard fileSize < Float(maxFileSizeMB) else {
            showOutOfSizeAltert()
            return
        }
        delegage?.didPickFileAt(url: url)
    }
    
    private
    func didPickImageAt(url: URL) {
        let fileSize = getFileSizeOfMB(url: url)
        guard fileSize < Float(maxFileSizeMB) else {
            showOutOfSizeAltert()
            return
        }
        delegage?.didPickFileAt(url: url)
    }
    
    private
    func getFileSizeOfMB(url: URL) -> Float {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: url.path) else {
            return 0
        }
        
        do {
            let fileDic = try fileManager.attributesOfItem(atPath: url.path)
            let size = fileDic[.size] as? UInt64
            return Float(size ?? 0)/1024.0/1024.0;
        } catch  {
            return 0;
        }
    }
    
    private
    func showOutOfSizeAltert() {
        let alterControl = UIAlertController(title: "提示", message: "文件大小超过\(maxFileSizeMB)M, 无法上传", preferredStyle: .alert)
        alterControl.addAction(.init(title: "知道了", style: .cancel, handler: nil))
        sender?.present(alterControl, animated: true, completion: nil)
    }
    
    private
    func getParamDic(from url: URL) -> [String: String] {
        var result = [String: String]()
        
        if let query = url.query {
            let arr = query.components(separatedBy: "&")
            for ele in arr {
                let temp = ele.components(separatedBy: "=")
                if temp.count == 2 {
                    result[temp[0]] = temp[1]
                }
            }
        }
        
        return result
    }
    
    private
    func generateFileName(with url: URL) -> String {
        let info = getParamDic(from: url)
        var fileName: String!
        if let id = info["id"],
           let ext = info["ext"] {
            fileName = id + "." + ext
        }else {
            fileName = url.lastPathComponent
        }
        return fileName
    }
    
    private
    func generateFileName() -> String {
        let fileName = NSUUID().uuidString + ".jpeg"
        return fileName
    }
    
    private
    func saveToTempDirectory(with fileName: String, data: Data) -> URL? {
        let toPath = NSTemporaryDirectory() + fileName
        let toUrl = URL(fileURLWithPath: toPath)
        do {
            try data.write(to: toUrl, options: .atomic)
        } catch {
            print(logTag, error)
            return nil
        }
        
        return toUrl
    }
}

extension HTFilePickerController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        didPickDocumentsAt(urls: [url])
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        didPickDocumentsAt(urls: urls)
    }
}

extension HTFilePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var url: URL?
        debugPrint(info)
        if let mediaType = info[.mediaType] as? NSString {
            switch mediaType as CFString {
            case kUTTypeImage:
                if #available(iOS 11.0, *) {
                    if let t = info[.imageURL] as? URL {
                        url = t
                    } else if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                        if let data = image.pngData() {
                            url = saveToTempDirectory(with: generateFileName(), data: data)
                        } else if let data = image.jpegData(compressionQuality: 1) {
                            url = saveToTempDirectory(with: generateFileName(), data: data)
                        }
                    }
                } else {
                    if let tempUrl = info[.referenceURL] as? URL,
                       let image = info[.originalImage] as? UIImage {
                        if let data = image.pngData() {
                            url = saveToTempDirectory(with: generateFileName(with: tempUrl), data: data)
                        } else if let data = image.jpegData(compressionQuality: 1) {
                            url = saveToTempDirectory(with: generateFileName(with: tempUrl), data: data)
                        }
                    }
                }
            case kUTTypeMovie:
                url = info[.mediaURL] as? URL
            default:
                break;
            }
        }
        
        picker.dismiss(animated: true) { [weak self] in
            if let result = url {
                self?.didPickImageAt(url: result)
            }
        }
    }
}
