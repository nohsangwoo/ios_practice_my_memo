//
//  MemoListVC.swift
//  Noh_My_Memo
//
//  Created by Noh Sangwoo on 2022/12/11.
//

import UIKit

class MemoListVC: UITableViewController {
    // 앱 델리게이트 객체의 참조 정보를 가져온다.`
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 테이블 뷰의 셀 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let count = self.appDelegate.memolist.count
      return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        
        // 2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage" 에 폼을 맞춰 렌더링 한다.
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        
        // 3. 재사용 큐로부터 프로포타입 셀의 인스턴스를 전달 받는다
        // (렌더링 할 cell의 종류를 cellId로 분기를 나누는 로직)
        // (시스템 리소스의 절약과 퍼포먼스를 위해 매번 새로 테이블을 셀을 만드는 대신 가급적 이미 만들어진 셀을 재사용 할 수 있도록 처리)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        
        // 4. memoCell의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        
        // 5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)

        
        // 6. cell 객체를 리턴한다.
        return cell
    }
    
    // 디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
    // 비슷한 기능으로 viewDidAppear 라이프사이클 메소드가 있다 알아볼 것
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        // (라이프 사이클 중 하나인것 같다, 이 경우 tableView가 렌더링 될때마다 최신화가 이루어져야하기때문에 이런짓을 한다..예컨데 수동 리렌더링이다.)
        self.tableView.reloadData()
    }
    
    
    // 테이블 행을 선택했을때 호출되는 메소드. onClick과 비슷한 이벤트 리스너
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //      // ① memolist 배열에서 선택된 행에 맞는 데이터를 꺼낸다.
        //      let row = self.appDelegate.memolist[indexPath.row]
        //
        //      // ② 상세 화면의 인스턴스를 생성한다.
        //      guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
        //        return
        //      }
        //
        //      // ③ 값을 전달한 다음, 상세 화면으로 이동한다.
        //      vc.param = row
        //      self.navigationController?.pushViewController(vc, animated: true)
    }
}
