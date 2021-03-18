//
//  YDBook.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import HandyJSON

struct UserInfo:HandyJSON{
    var gender:String?//": "女",
    var idCard:String?//": "123123",
    var schoolType:String?//": "1",
    var className : String?//": "广东班",
    var availablePoints:Int?//": 210,
    var avatar : String?//": "http://ro.bnuz.edu.cn/user/default/img_girl.png",
    var rankTitle:String?//": "儒生",
    var userName:String?//": "学生甲",
    var classId:String?//": "40d7c708-ca49-409f-8419-91287efaea36",
    var userPoints:String?//": "500",
    var grade:String?//": "二年级",
    var schoolId:String?//": "1000000",
    var rank:String?//": "2",
    var schoolName:String?//": "阅读海洋小学"
}



struct Book : HandyJSON {
    var id:String?
    var name:String?
    var picUrl:String?
    var author:String?
    
    var introduction:String?
    var recommend:String?
    var pages:Int?
    var categoryId:String?
    var publishingHouse:String?
    var remark:String?
    var category:String?
    var topicId:String?
    
}

struct QueryBook: HandyJSON{
    var id: String?
    var title: String?
    var coverImg: String?
}

///任务记录
struct Record:HandyJSON {
    var date: TimeInterval?
    var accuracy:Double? //0.7333333333333333,
    var consume: TimeInterval?
}

///课程
struct Course:HandyJSON {
    var author: String?//": "王慧杰",
    var video: String?//": "http://ro.bnuz.edu.cn/tinyread/book/5917bd81-2daa-4cef-a940-9fec3a070f8c/index.html",
    var title:String?//": "了不起的狐狸爸爸"
}
struct BookDetail:HandyJSON{

    
    var courses:[Course]?
    var comments:[String]?
    var coverImg:String?// http://ro.bnuz.edu.cn/book/category_tonghua/7f20b155-cf83-4d42-93e8-95310975afe7.png,
    var records:[Record]?  //[{date: 1567089540931, accuracy: 0.7333333333333333, consume: 184 }, {date: 1551862195839,…],
    var author:String? // （丹麦）安徒生 著，叶君健 译,
    var publishDate:TimeInterval?// 702057600000,
    var title:String?// 安徒生童话,
    var hasComment:Bool?// true,
    var isDone:Bool?// true,
    var blockId:String?// bcc0261b-f363-4506-91bc-5da17c8bab67,
    var hasTask:Bool?// true,
    var readNum:Int?// 3173,
    var review:String?// 安徒生的童话不单是为了丰富孩子们的精神生活，也为了启发成年人，因此，它不仅为儿童，也为成人所喜爱。而他的童话具有一般成人文学所欠缺的特点：丰富的幻想，天真烂漫的构思和朴素的幽默感。这些都植根于现实生活。他的许多脍炙人口的童话都具有这种特色。如《夜鹰》、《豌豆上的公主》、《皇帝的新装》、《牧羊女》、《扫烟囱的人》等都充满了浓郁的生活气息。在他的童话中，他以满腔热情表达了他对人间的爱，对人间的关怀，对人的尊严的重视，对人类进步的赞颂。如《海的女儿》等。\n在这套新译本的安徒生童话故事集中你可以读到安徒生早、中、晚三个时期的大部分作品。译文文笔生动。其间还附有大量的精美彩图，是一部不可错过的文学佳作。,
    var readingNum:Int?// 1819,
    var press:String?// 人民文学出版社,
    var buySrc:[String:String]?//src: p0GPI0XmvgliQwb8rIlK897Wxh0c
    var introduction:String? // 本书收集了安徒生文学作品，主要包括海的女儿、邻居们、夜莺、丑小鸭、她是一个废物、豌豆上的公主、打火匣、皇帝的新装、顽皮孩子、野天鹅、凤凰、柳树下的梦、衬衫领子、小鬼和小商人、世上最美丽的一朵玫瑰花、天鹅的窠、甲虫、小意达的花儿、完全是真的、雪人、树精、拇指姑娘、区别园丁和主人、最后的珠子、纸牌、笨汉汉斯、坚定的锡兵、新世纪的女神、老头子做事总不会错、雏菊、冰姑娘、飞箱、卖火柴的小女孩、安琪儿、幸运的套鞋、光荣的荆棘路、牧羊女和扫烟囱的人、单身汉的睡帽、蝴蝶、夏日痴、一个贵族和他的女儿们、癞蛤蟆、沙丘的故事、一枚银毫、烂布片、开门的钥匙、两个海岛、谁是最幸运的、没有画的画册等详细内容。,
    var creature:[String:String]? //img: http://ro.bnuz.edu.cn/ocean/ocean_animal_type_paxing/0ca3b034-22cb-43d8-b4bd-4fce448486d5.gif,
    //name: 棱皮龟-铁灰
    
}

struct Block:HandyJSON {
    var img:String?
    //讨论
    var postNum:Int?
    //点赞
    var likeNum:Int?
    var title:String?
    var id:String?
}
struct MyBlock {
    var img:String?
    //讨论
    var postNum:Int?
    //点赞
    var likeNum:Int?
    var title:String?
    var blockId:String?
    var bookId:String?
    var author:String?
    var introduction:String?
}

enum TaskType{
    case none(_ rawValue:String = "")
    case done(_ rawValue:String = "done")
    case pending(_ rawValue:String = "pending")
    case overdue(_ rawValue:String = "overdue")
}
struct Task:HandyJSON{
    
    var id:String?
    var startDate: TimeInterval?
    var endDate: TimeInterval?
    var title: String?
    var publisher: String?
    var isDone: Bool?
    var hasComment: Bool?

    
}
struct ReturnData<T: HandyJSON>: HandyJSON {
    var result:String?
    var data: T?
    var code: Int = 0
}

struct ReturnWithDataList<T: HandyJSON>: HandyJSON{
    var totalPage:Int?
    var dataList:[T]?
    var currentPage:Int = 1
}

