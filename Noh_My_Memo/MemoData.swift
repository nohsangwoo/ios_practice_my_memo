//
//  MemoData.swift
//  Noh_My_Memo
//
//  Created by Noh Sangwoo on 2022/12/11.
//

//import Foundation

// 이 파일은 일종의 API res 모킹 데이터 Type이고
// MemoData라는 객체의 Type이라고 생각 하면 된다.
import UIKit


class MemoData {
  var memoIdx : Int? // 데이터 식별값
  var title : String? // 메모 제목
  var contents : String? // 메모 내용
  var image : UIImage? // 이미지
  var regdate : Date? // 작성일
}

//class MemoData {
//    var memoIndex : Int?  // 데티어 삭제값
//    var title : String?  // 메모 제목
//    var contents : String?  // 메모 내용
//    var image: UIImage  // 이미지
//    var regdate : Date?  // 작성일
//}


