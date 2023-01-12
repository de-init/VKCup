import Foundation

struct Question {
    var question: String
    var answer_1: String
    var answer_2: String
    var answer_3: String
    var answer_4: String
    var correctAnswer: String
}

extension Question {
    public static var list: [Question] {
        return [
            Question(question: "Когда пала Берлинская стена?", answer_1: "1988", answer_2: "1989", answer_3: "1990", answer_4: "1991", correctAnswer: "1989"),
            Question(question: "Как долго длилась Столетняя война?", answer_1: "116 лет", answer_2: "100 лет", answer_3: "50 лет", answer_4: "101 год", correctAnswer: "116 лет"),
            Question(question: "Какая планета находится ближе всего к Солнцу?", answer_1: "Земля", answer_2: "Марс", answer_3: "Венера", answer_4: "Меркурий", correctAnswer: "Меркурий"),
            Question(question: "“K” - это химический символ какого элемента?", answer_1: "Хром", answer_2: "Титан", answer_3: "Водород", answer_4: "Калий", correctAnswer: "Калий"),
            Question(question: "Что является столицей Австралии?", answer_1: "Канберра", answer_2: "Аделаида", answer_3: "Сидней", answer_4: "Мельбурн", correctAnswer: "Канберра"),
            Question(question: "Какой самый большой остров в мире?", answer_1: "Исландия", answer_2: "Финляндия", answer_3: "Гренландия", answer_4: "Ирландия", correctAnswer: "Гренландия"),
        ]
    }
}
