//
//  ContentView.swift
//  Connect-4-iOS-Game
//
//  Created by 莊智凱 on 2022/3/18.
//

import SwiftUI

struct ContentView: View {
    
    enum Hole { case blank, user, computer }
    enum Turn { case user, computer, userWin, computerWin, tie }
    
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    @AppStorage("playerPiecesColor") var playerPiecesColor = Color.red
    @AppStorage("computerPiecesColor") var computerPiecesColor = Color.yellow
    
    @State private var usrPiece = 21
    @State private var computerPiece = 21
    @State private var hole = Array(repeating: Hole.blank, count: 42)
    @State private var turn = Turn.user
    @State private var connectIdx : [Int] = []
    @State private var selectTab = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    HStack {
                        Text(" Win：\(win) ")
                            .padding(8)
                            .background(Color(red: 209/255, green: 231/255, blue: 255/255))
                            .cornerRadius(15)
                        Spacer()
                        Text(" Lose：\(lose) ")
                            .padding(8)
                            .background(Color(red: 209/255, green: 231/255, blue: 255/255))
                            .cornerRadius(15)
                        Spacer()
                        Text(" Tie：\(tie) ")
                            .padding(8)
                            .background(Color(red: 209/255, green: 231/255, blue: 255/255))
                            .cornerRadius(15)
                    }
                    .font(.title)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Circle()
                            .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            .foregroundColor(playerPiecesColor)
                        VStack {
                            HStack {
                                Text("You")
                                Spacer()
                                Text("Computer")
                            }
                            .font(.title3.bold())
                            HStack {
                                Text("\(usrPiece)")
                                Spacer()
                                Text("vs")
                                Spacer()
                                Text("\(computerPiece)")
                            }
                        }
                        Circle()
                            .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            .foregroundColor(computerPiecesColor)
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                        ForEach(0..<42) { index in
                            switch hole[index] {
                            case .blank:
                                Circle()
                                    .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        if(turn == .user) {
                                            playerTurn(index: index)
                                        }
                                    }
                            case .user:
                                if connectIdx.contains(index) {
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(playerPiecesColor))
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                } else {
                                    Circle()
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                        .foregroundColor(playerPiecesColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index%7] == .blank) {
                                                playerTurn(index: index)
                                            }
                                        }
                                }
                            case .computer:
                                if connectIdx.contains(index) {
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(computerPiecesColor))
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                } else {
                                    Circle()
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                        .foregroundColor(computerPiecesColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index%7] == .blank) {
                                                playerTurn(index: index)
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Spacer()
                        switch turn {
                        case .user:
                            Text("Your Turn")
                                .bold()
                                .font(.largeTitle)
                        case .computer:
                            Text("Computer's Turn")
                                .bold()
                                .font(.largeTitle)
                        case .userWin:
                            Text("  You Win！")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        case .computerWin:
                            Text("You Lose...")
                                .bold()
                                .font(.largeTitle)
                        case .tie:
                            Text("Tie")
                                .bold()
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    .padding(8)
                    .background(Color(red: 209/255, green: 231/255, blue: 255/255))
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                    
                    if(turn != .user && turn != .computer) {
                        HStack {
                            Spacer()
                            Button {
                                usrPiece = 21
                                computerPiece = 21
                                hole = Array(repeating: .blank, count: 42)
                                turn = .user
                                connectIdx = []
                            } label: {
                                Text("Next Round")
                                    .bold()
                                    .font(.largeTitle)
                            }
                            Spacer()
                        }
                        .padding(8)
                        .background(Color(red: 209/255, green: 231/255, blue: 255/255))
                        .cornerRadius(15)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Connect 4")
                            .bold()
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                if(turn != .computer) {
                                    usrPiece = 21
                                    computerPiece = 21
                                    hole = Array(repeating: .blank, count: 42)
                                    turn = .user
                                    connectIdx = []
                                }
                            } label: {
                                Image(systemName: "arrow.counterclockwise.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width/15, height: geometry.size.width/15)
                                    .padding(8.5)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width/15, height: geometry.size.width/15)
                                    .padding(8.5)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func playerTurn(index: Int) {
        turn = .computer
        usrPiece -= 1
        var topIdx = index % 7
        var blankNum = 0
        while (hole[topIdx] == .blank && topIdx+7 <= 41 && hole[topIdx+7] == .blank) {
            blankNum += 1
            topIdx += 7
        }
        var idx = index % 7
        for i in 0...blankNum {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                if(idx>6) {
                    self.hole[idx-7] = .blank
                }
                self.hole[idx] = .user
                idx += 7
                if(i == blankNum) {
                    checkFinish()
                    if(turn == .computer) {
                        computerTurn()
                    }
                }
            }
        }
    }
    
    func computerTurn() {
        computerPiece -= 1
        // check "|"
        for row in 0...2 {
            for col in 0...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                    && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                    computerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "\" and drop at left
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+8] != .blank
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                    computerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "\" and drop at right
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+8]
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+24] == .blank) {
                    if(7*row+col+31<=41 && self.hole[7*row+col+31] != .blank) {
                        computerDrop(col: col+24, row: row+3)
                        return
                    } else if(7*row+col+31>41) {
                        computerDrop(col: col+24, row: row+3)
                        return
                    }
                }
            }
        }
        // check "/" and drop at left
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+6]
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+18] == .blank) {
                    if(7*row+col+25<=41 && self.hole[7*row+col+25] != .blank) {
                        computerDrop(col: col+18, row: row+3)
                        return
                    } else if(7*row+col+25>41) {
                        computerDrop(col: col+18, row: row+3)
                        return
                    }
                }
            }
        }
        // check "/" and drop at right
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+6] != .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                    computerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "-" and drop at left to win
        for row in 0...5 {
            for col in 0...3 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+1] == .computer
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                    && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        computerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at right to win
        for row in 0...5 {
            for col in 3...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col-1] == .computer
                    && self.hole[7*row+col-1] == self.hole[7*row+col-2]
                    && self.hole[7*row+col-2] == self.hole[7*row+col-3]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        computerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at left to prevent user win
        for row in 0...5 {
            for col in 0...4 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+1] == .user
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        computerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at right to prevent user win
        for row in 0...5 {
            for col in 2...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col-1] == .user
                    && self.hole[7*row+col-1] == self.hole[7*row+col-2]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        computerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        
        var col = Int.random(in: 0...6)
        while (self.hole[col] != .blank) {
            col = Int.random(in: 0...6)
        }
        var blankNum = 0
        while (hole[col] == .blank && col+7 <= 41 && hole[col+7] == .blank) {
            blankNum += 1
            col += 7
        }
        computerDrop(col: col, row: blankNum)
    }
    
    func computerDrop(col: Int, row: Int) {
        var idx = col % 7
        for i in 0...row {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                if(idx>6) {
                    self.hole[idx-7] = .blank
                }
                self.hole[idx] = .computer
                idx += 7
                if(i == row) {
                    checkFinish()
                    if(turn == .computer) {
                        if(computerPiece == 0) {
                            turn = .tie
                            tie += 1
                        } else {
                            turn = .user
                        }
                    }
                }
            }
        }
    }
    
    func checkFinish() {
        // check "|"
        for row in 0...2 {
            for col in 0...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+7]
                    && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                    && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                    connectIdx.append(7*row+col)
                    connectIdx.append(7*row+col+7)
                    connectIdx.append(7*row+col+14)
                    connectIdx.append(7*row+col+21)
                    if(self.hole[7*row+col] == .user) {
                        turn = .userWin
                        win += 1
                    } else {
                        turn = .computerWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "-"
        for row in 0...5 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+1]
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                    && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                    connectIdx.append(7*row+col)
                    connectIdx.append(7*row+col+1)
                    connectIdx.append(7*row+col+2)
                    connectIdx.append(7*row+col+3)
                    if(self.hole[7*row+col] == .user) {
                        turn = .userWin
                        win += 1
                    } else {
                        turn = .computerWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "\"
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+8]
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                    connectIdx.append(7*row+col)
                    connectIdx.append(7*row+col+8)
                    connectIdx.append(7*row+col+16)
                    connectIdx.append(7*row+col+24)
                    if(self.hole[7*row+col] == .user) {
                        turn = .userWin
                        win += 1
                    } else {
                        turn = .computerWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "/"
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+6]
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                    connectIdx.append(7*row+col)
                    connectIdx.append(7*row+col+6)
                    connectIdx.append(7*row+col+12)
                    connectIdx.append(7*row+col+18)
                    if(self.hole[7*row+col] == .user) {
                        turn = .userWin
                        win += 1
                    } else {
                        turn = .computerWin
                        lose += 1
                    }
                    return
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
