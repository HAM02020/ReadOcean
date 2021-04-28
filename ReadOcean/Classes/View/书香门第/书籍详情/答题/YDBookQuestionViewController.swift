//
//  YDBookQuestionViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/23.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import WebKit
import HandyJSON
import SwiftyJSON
struct Answer: HandyJSON {
    var bookId: String?
    var isCorrect: String?
}
struct AnsList: HandyJSON{
    var list: [Answer]?
}

class YDBookQuestionViewController: BaseViewController{
    
    var bookId: String?
    
    var handleHTMLBlock: ()->Void = {}
    
    var questionList = [Question]()
    
    var turn = 0
    
    var history = [Int:[Int]]()
    var answerToCommit = [String:Any]()
    
    private lazy var webView: WKWebView = {
        let v = WKWebView()
        v.navigationDelegate = self
        
        return v
    }()
    
    private lazy var imgBG: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "questionBG")
        v.contentMode = .scaleAspectFill

        
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero, style: .grouped)
        t.delegate = self
        t.dataSource = self
        t.register(cellType: YDBookQuestionTableViewCell.self)
        t.rowHeight = 100
        t.backgroundColor = UIColor.clear
        return t
    }()
    @objc private func pop(){
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestions()
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(pop))
        pan.edges = .left
        view.addGestureRecognizer(pan)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "上一题", style: .plain, target: self, action: #selector(preQuestion)), animated: false)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.setRightBarButton(UIBarButtonItem(title: "下一题", style: .plain, target: self, action: #selector(nextQuestion)), animated: false)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0))

    }
    
    override func setupLayout() {
        view.addSubview(imgBG)
        imgBG.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    @objc private func preQuestion(){
        if(turn <= 0) {
            ProgressHUD.showError("已经是第一题", image: nil, interaction: true)
            return
            
        }
        navigationItem.rightBarButtonItem?.title = "下一题"
        navigationItem.rightBarButtonItem?.action = #selector(nextQuestion)
        turn -= 1
        tableView.reloadData()
    }
    @objc private func nextQuestion(){
        if(turn >= questionList.count - 1) {return}
        turn += 1
        if(turn >= questionList.count - 1) {
            navigationItem.rightBarButtonItem?.title = "提交"
            navigationItem.rightBarButtonItem?.action = #selector(commit)
        }
        tableView.reloadData()
    }
    @objc private func commit(){
        var ansList = AnsList()
        ansList.list = [Answer]()
        for i in 0..<history.count{
            var ans = Answer()
            ans.bookId = bookId
            var answer = ""
            for his in history[i]!{
                answer.append("\(his)")
            }
            ans.isCorrect = questionList[i].isCorrect(choice: answer) ? "1" : "0"
            ansList.list?.append(ans)
        }
        let json = ansList.list?.toJSONString() ?? ""
        print("json = \(json)")
        Api.networkManager.request(.commitBookQuestion(bookId: bookId!, detailJson: json)) { (result) in
            switch result{
            case .success(let req):
                let json = JSON(req.data)
                let code = json["code"].intValue
                if(code == 200){
                    ProgressHUD.showSucceed("答题成功", interaction: true)
                    for vc in self.navigationController?.viewControllers ?? []{
                        if(vc.isKind(of: BookDetailVC.self)){
                            (vc as! BookDetailVC).loadData()
                        }
                    }
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    print(try? req.mapString())
                }
                self.navigationController?.popViewController(animated: true)
                
                break
                
            default:
                print("失败")
                break
            }
        }
        
    }
    private func click(turn: Int,index:Int,cell:YDBookQuestionTableViewCell){
        guard (history[turn] != nil) else {
            history[turn] = [Int]()
            history[turn]?.append(index)
            cell.setOn()
            return
        }
        if(history[turn]!.contains(index)){
            history[turn]?.removeAll{$0 == index}
            cell.setOff()
        }
        else{
            if(questionList[turn].questionType() == .danxuan && history[turn]!.count > 0){
                ProgressHUD.showError("此题是单选题", image: nil, interaction: true)
                return
            }
            history[turn]!.append(index)
            cell.setOn()
        }
        
        
        
    }
    private func getQuestions(){
        guard let token = UserAccount.shardAccount.token,
              let bookId = bookId
              else {return}
        let url = URL(string: "https://ro.bnuz.edu.cn/ReadingOcean/mbookq/singleq/query?bookId=\(bookId)")!
        var req = URLRequest(url: url)
        req.addValue(token, forHTTPHeaderField: "Authorization")
        handleHTMLBlock = {[weak self] in
            self?.webView.evaluateJavaScript("document.body.innerHTML") { (result, _) in
                
                guard let questionList = self?.parseJson(result: result) else {return}
                self?.questionList = questionList
                self?.tableView.reloadData()

            }
        }
        webView.load(req)
        
    }
    private func parseJson(result:Any?) -> [Question]?{
        print(result)
        guard var result = result as? String,
              let reg = try? NSRegularExpression(pattern: "<(.*?)>", options: [])
              
        else {return nil}
        while((reg.firstMatch(in: result, options: [], range: NSRange(location: 0, length: result.count))) != nil){
            let match = reg.firstMatch(in: result, options: [], range: NSRange(location: 0, length: result.count))!
            result = (result as NSString).replacingCharacters(in: match.range(at: 0), with: "")
        }
        let dataList = ReturnWithDataList<Question>.deserialize(from: result)
        print(dataList)
        return dataList?.dataList
        
        
    }
}

extension YDBookQuestionViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        handleHTMLBlock()
    }
}

extension YDBookQuestionViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        if(turn >= questionList.count){ return 1}
        return questionList[turn].numOfChoices()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section != 0){ return 0}
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section != 0){return nil}
        if(turn >= questionList.count){ return nil}
        let title = questionList[turn].question ?? ""
        let v = YDBookQuestionHeaderView(title: title)
        return v
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: YDBookQuestionTableViewCell.self)
        
        if(turn >= questionList.count){ return cell}
        
        //设置选项
        let questionModel = questionList[turn]
        var text:String?
        switch questionModel.questionType() {
        case .panduan:
            text = indexPath.section == 0 ? "正确" : "错误"
        case .danxuan, .duoxuan:
            text = questionModel.getChoice(index: indexPath.section)
        default:
            break;
        }
        cell.question = text
        print("turn = \(turn)")
        print("history = \(history)")
        //判断历史是否点击
        guard let hisList = history[turn] else {cell.setOff();return cell}
        if(hisList.contains(indexPath.section)){cell.setOn()}
        else{cell.setOff()}
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! YDBookQuestionTableViewCell
        click(turn: turn, index: indexPath.section,cell: cell)
    }
    
}
