//
//  MemoFormVC.swift
//  Noh_My_Memo
//
//  Created by Noh Sangwoo on 2022/12/11.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var subject: String!
    //    weak는 해당 변수의 라이프 사이클 규칙을 설정하는 구문이다(strong, weak이 존재한다)
    //    메모리 누수 현상이 발생할때 쉽게 메모리 확보를 할 수 있는 대상인지 아닌지를 판별한다.
    //    strong 타입의 경우는 다른곳에서 해당 변수가 참조 하고있다면 카운트를 증가시켜 해당 변수를 해제하여 메모리 확보를 할 수 없다.
    //    따라서 특별한 상황이 아니라면 아웃렛 변수는 weak로 선언한다.
    //    other case: 순환참조 오류를 방지를 위해서
    //    키워드 ARC(Auto Reference Counter)
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
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
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}
