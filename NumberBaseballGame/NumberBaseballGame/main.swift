//
//  main.swift
//  functionPractice
//
//  Created by t2023-m0049 on 3/14/24.
//

import Foundation

let game = BaseballGame()
game.start()

class BaseballGame {
    func start() {
        let answer = makeAnswer()
        //        print(answer)
        
        while true {
            print("세 자리 수를 입력하세요:")
            guard let input = readLine(), let userNum = Int(input) else {
                print("숫자를 입력하세요.") //입력한 값이 숫자가 아니면 "숫자를 입력하세요"를 반환하고, 숫자면 다음으로 계속해서 넘어간다.
                continue
            }
            
            guard isThreeDigitNumber(userNum) else {
                print("세 자리 수가 아닙니다.") //입력한 값이 숫자인데 세 자리수가 아니면 "세 자리 수를 입력하세요"를 반환하고, 세 자리수이면 다음으로 계속해서 넘어간다.
                continue
            }
            
            guard hasNoDuplicates(userNum) else {
                print("같은 숫자를 중복해서 입력하지 마세요.") //입력한 값이 숫자이고 세 자리수인데 같은 숫자가 중복해서 들어가면 "같은 숫자를 중복해서 입력하지 마세요"를 반환하고, 같은 숫자가 중복되지 않으면 다음으로 계속해서 넘어간다.
                continue
            }
            
            let result = checkResult(userNum, answer) //userNum과 answer를 파라미터로 하는 함수 checkResult를 인스턴스화하여 result에 넣는다
            print("결과:", result)
            
            if result == "3 스트라이크, 0 볼" { //resultrk "3 스트라이크, 0 볼"이 나오면 "정답입니다!"를 인쇄하고 멈춰라
                print("정답입니다!")
                break
            }
        }
    }
    
    func makeAnswer() -> Int {
        let arr: [Int] = [0,1,2,3,4,5,6,7,8,9]
        var answerArr: [Int] = []
        
        for i in arr { //0~9까지의 정수가 담긴 배열 arr에서 수 하나를 꺼내 i로 하고
            for j in arr { //0~9까지의 정수가 담긴 배열 arr에서 수 하나를 꺼내 j로 하고
                for k in arr { //0~9까지의 정수가 담긴 배열 arr에서 수 하나를 꺼내 k로 하여 수 3개를 뽑고
                    if i == j || j == k || k == i { //i=j 또는 j=k 또는 k=i면(중복되는 수가 나왔으면)
                        continue //맨위의 for문으로 돌아가 i부터 다시 뽑고 중복되는 수가 없으면 멈춘다
                    }
                    if i == 0 { //i에 0이 나오면 맨 위의 for문으로 돌아가 i부터 다시 뽑는다
                        continue
                    }
                    let result = i * 100 + j * 10 + k // i,j,k를 각각 백의 자리, 십의 자리, 일의 자리 수로 변환해 세 자리 수로 만든다
                    answerArr.append(result) //answerArr라는 배열에 result를 추가한다
                }
            }
        }
        let randomAnswer = answerArr.randomElement() ?? 0 //answerArr에서 랜덤으로 하나를 뽑는다. 안 뽑으면 0을 반환한다.
        return randomAnswer // 무작위로 뽑은 randomAnswer를 반환한다
    }
    
    func isThreeDigitNumber(_ num: Int) -> Bool { //isThreeDigitNumber라는 함수는 100이상 999이하면(세 자리 정수이면) true를 반환한다
        return num >= 100 && num <= 999
    }
    
    func hasNoDuplicates(_ num: Int) -> Bool { //hasNoDuplicates라는 함수는 Int형 파라미터인 num을 받아 String으로 변환한 것을 digits라는 상수로 두고 digits에서 중복인 수를 제거한 후의 개수가 3개이면 true를 반환한다
        let digits = String(num)
        return Set(digits).count == 3
    }
    
    func checkResult(_ userNum: Int, _ answer: Int) -> String {
        let userDigits = Array(String(userNum)) //사용자가 입력한 uswerNum을 String타입으로 변환하고 배열을 만들어서 userDigits라는 상수에 담는다
        let answerDigits = Array(String(answer)) //랜덤으로 고른 정답 answer를 String타입으로 변환하고 배열을 만들어서 answerDigits라는 상수에 담는다
        
        var strike = 0 //변수 strike를 초기화한다.
        var ball = 0 //변수 ball을 초기화한다.
        
        for i in 0..<3 { //0,1,2 중에서 하나를 꺼내는 것을 반복한다
            if userDigits[i] == answerDigits[i] { //answerDigits와 userDigits가 위치와 값이 같으면 strike에 1을 더한다
                strike += 1
            } else if answerDigits.contains(userDigits[i]) { //같은 자리는 아니지만 answerDigits에 userDigits가 뽑은 i가 포함되어 있으면 ball에 1을 더한다
                ball += 1
            }
        }
        
        if strike == 0 && ball == 0 { // strike와 ball이 모두 0이면 "Nothing"을 반환해라
            return "Nothing"
        } else { //strike와 ball이 모두 0이 아니면 "()스트라이크, ()볼"을 반환해라
            return "\(strike) 스트라이크, \(ball) 볼"
        }
    }
}
