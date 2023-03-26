//
//  QuestionsData.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

struct QuestionsData {
    
    let questions = [
        Question(question: "Что хором кричат дети на новогоднем празднике?",
                 answers: ["Помогите!", "«Зенит» — чемпион!", "Снегурочка!", "Раунд"],
                 rightAnswer: 3, cash: 100),
        
        Question(question: " У какой птицы спрашивают, сколько лет осталось прожить?",
                 answers: ["Ворона", "Кукушка", "Cова", "Дятел"],
                 rightAnswer: 2, cash: 200),
        
        Question(question: "Что нередко просят соблюдать, приглашая на светский раут?",
                 answers: ["Диету", "Дресс-код", "Клятву", "Шаббат"],
                 rightAnswer: 2, cash: 300),
        
        Question(question: "Что можно увидеть на картине Перова, место действия которой Мытищи?",
                 answers: ["Самокат", "Самолет", "Самосвал", "Самовар"],
                 rightAnswer: 4, cash: 500),
        
        Question(question: "Что в 90-е годы прошлого века было модно превращать в варёнку?",
                 answers: ["Ткань", "Грибы", "Макулатуру", "Серебро"],
                 rightAnswer: 1, cash: 1000),
        
        Question(question: "Какой из этих актеров не играл в кино Джеймса Бонда?",
                 answers: ["Шон Коннери", "Сильвестр Сталлоне", "Тимоти Далтон", "Дэниел Крейг"],
                 rightAnswer: 2, cash: 2000),
        
        Question(question: "Что такое десница?",
                 answers: ["Бровь", "Глаз", "Шея", "Рука"],
                 rightAnswer: 4, cash: 4000),
        
        Question(question: "В какое море впадает река Урал?",
                 answers: ["Азовское", "Чёрное", "Средиземное", "Каспийское"],
                 rightAnswer: 4, cash: 8000),
        
        Question(question: "На что кладут руку члены английского общества лысых во время присяги?",
                 answers: ["Кокосовый орех", "Баскетбольный мяч", "Бильярдный шар", "Апельсин"],
                 rightAnswer: 3, cash: 16_000),
        
        Question(question: "Как назывался каменный монолит, на котором установлен памятник Петру I в Санкт-Петербурге?",
                 answers: ["Дом-камень", "Гром-камень", "Гора-камень", "Разрыв-камень"],
                 rightAnswer: 2, cash: 32_000),
        
        Question(question: "Как Пётр Ильич Чайковский назвал свою серенаду для скрипки с оркестром си-бемоль минор?",
                 answers: ["Флегматическая", "Меланхолическая", "Холерическая", "Сангвиническая"],
                 rightAnswer: 2, cash: 64_000),
        
        Question(question: "Какого ордена не было у первого советского космонавта Юрия Гагарина?",
                 answers: ["Орден двойного дракона (Китай)", "Ожерелье Нила (Египет)", "Крест Грюнвальда (Польша)", "Плайя Хирон (Куба)"],
                 rightAnswer: 1, cash: 125_000),
        
        Question(question: "Какое животное имеет второе название — кугуар?",
                 answers: ["Оцелот", "Леопард", "Пума", "Пантера"],
                 rightAnswer: 3, cash: 250_000),
        
        Question(question: "Что в России 19 века делали в дортуаре?",
                 answers: ["Ели", "Спали", "Ездили верхом", "Купались"],
                 rightAnswer: 2, cash: 500_000),
        
        Question(question: "Какой химический элемент назван в честь злого подземного гнома?",
                 answers: ["Гафний", "Бериллий", "Теллур", "Кобальт"],
                 rightAnswer: 4, cash: 1_000_000)
    ]

    func getQuestionCash(questionNumber: Int) -> Int {
        return questions[questionNumber - 1].cash
    }

    func getRightAnswerIndex(questionNumber: Int) -> Int {
        return questions[questionNumber - 1].rightAnswer - 1
    }
    
   
}
