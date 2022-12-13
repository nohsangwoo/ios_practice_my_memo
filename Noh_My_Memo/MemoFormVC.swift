//
//  MemoFormVC.swift
//  Noh_My_Memo
//
//  Created by Noh Sangwoo on 2022/12/11.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    //    weak는 해당 변수의 라이프 사이클 규칙을 설정하는 구문이다(strong, weak이 존재한다)
    //    메모리 누수 현상이 발생할때 쉽게 메모리 확보를 할 수 있는 대상인지 아닌지를 판별한다.
    //    strong 타입의 경우는 다른곳에서 해당 변수가 참조 하고있다면 카운트를 증가시켜 해당 변수를 해제하여 메모리 확보를 할 수 없다.
    //    따라서 특별한 상황이 아니라면 아웃렛 변수는 weak로 선언한다.
    //    other case: 순환참조 오류를 방지를 위해서
    //    키워드 ARC(Auto Reference Counter)
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // 라이프 사이클중 하나인듯, 아마도 view가 로드되면 어떤 작업을 하라는 의미같다.
    override func viewDidLoad() {
        self.contents.delegate = self
        // text view에 대한 델리게이트 패턴을 구현하기위한 작업
        // 화면이 로드되면 특정 델리게이트 메소드가 자동으로 호출되도록 할 수 있다.
    }
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
      // ① 내용을 입력하지 않았을 경우, 경고한다.
      guard self.contents.text.isEmpty == false else {
        let alert = UIAlertController(title: nil,
                                      message: "내용을 입력해주세요",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        return
      }
      // ② MemoData 객체를 생성하고, 데이터를 담는다.
      let data = MemoData()
      
      data.title = self.subject // 제목
      data.contents = self.contents.text // 내용
      data.image = self.preview.image // 이미지
      data.regdate = Date() // 작성 시각
      
      // ③ 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.memolist.append(data)
      
      // ④ 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
      _ = self.navigationController?.popViewController(animated: true)
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    // 내용을 입력하지 않았을 경우, 경고한다.
    @IBAction func pick(_ sender: Any) {
        // ------------ 델리게이트 패턴? ---------------------
        // 이미지 피커 컨트롤러는 델리게이트 패턴 기반으로 동작한다. (키워드 델리게이트 패턴?)
        
        // 뷰 컨트롤러가 이미지 피커 컨트롤러의 동작에 간섭하지 않을 테니, 특정 이벤트가 발생했을 때 뷰 컨트롤러 쪽에도 메소드 호출을 통해 알려달라는 것.
        // 이때 호출되는 메소드를 델리게이트 메소드라고한다.
        // 그니깐 일종의 트리거 형식으로 서로 동작하는것 같다.
        // ------------ end of 델리게이트 패턴? ---------------------
        
        // 이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        // 이미지 피커 컨트롤러 인스턴스의 델리게이트 속성을 현재의 뷰 컨트롤러 인스턴스로 설정한다.
        picker.delegate = self
        
        // 이미지 피커 컨트롤러의 이미지 편집을 허용한다.
        // 이와같이 이미지 피커 컨트롤러 인스턴스의 옵션 및 동작을 설정 할 수 있다.
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
    }
    
    
    
    
    
    // 사용자가 이미지를 선택하면 자동으로 이 메소드가 호출된다.
    // 델리게이트 메소드는 정해져있는 이름이 있다. 구현시 이름과 형식을 정확하게 작성해 줘야한다.
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        // 선택된 이미지를 미리보기에 출력한다.
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    // 사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출된다.
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ((contents.length>15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 네비게이션 타이틀에 표시한다.
        self.navigationItem.title = self.subject
    }
    
}

