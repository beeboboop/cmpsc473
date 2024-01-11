//
//  PieceView.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/13/23.
//

import SwiftUI

struct PieceView: View {
    @EnvironmentObject var manager : GameManager
    @Binding var piece : Piece
    @State private var offset : CGSize = CGSize.zero
    @State private var scale : CGSize = CGSize(width: 1, height: 1)
    var body: some View {
        let tapGesture = TapGesture()
            .onEnded { _ in
                if manager.canPieceRotate(piece) {
                    withAnimation {
                        piece.rotate()
                        piece.rotationAngle += piece.isMirrored ? (piece.isLandscape ? -270 : 90) : 90
                    }
                }
                else {
                    withAnimation(.linear(duration: 0.1)) {
                        piece.rotationAngle += 15
                    }
                    withAnimation(.linear(duration: 0.2).delay(0.1)) {
                        piece.rotationAngle -= 30
                    }
                    withAnimation(.linear(duration: 0.1).delay(0.3)) {
                        piece.rotationAngle += 15
                    }
                }
                if (piece.rotationAngle % 360 == 0) {piece.rotationAngle = 0}
            }
        let longPressGesture = LongPressGesture(minimumDuration: 0.35)
            .onEnded { _ in
                withAnimation {
                    piece.reflect()
                }
            }
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
                withAnimation {
                    scale = CGSize(width: 1.2, height: 1.2)
                }
            }
            .onEnded { value in
                withAnimation {
                    let offset = manager.offset(for: piece, from: offset)
                    piece.moveBy(offset: offset)
                    self.offset = CGSize.zero
                    scale = CGSize(width: 1, height: 1)
                }
            }
        let pentomino = Pentomino(outline: piece.outline)
        ZStack {
            pentomino
                .fill(Color.getPieceColor(piece: piece))
            pentomino
                .stroke(style: StrokeStyle(lineWidth: manager.lineWidth))
            Grid(n: manager.getWidth(outline: piece.outline), m: manager.getHeight(outline: piece.outline))
                .stroke(style: StrokeStyle(lineWidth: manager.lineWidth))
                .clipShape(pentomino)
        }
        .scaleEffect(scale)
        .rotationEffect(manager.getRotationAngleFor(piece))
        .rotation3DEffect(manager.getReflectionAngleFor(piece), axis: manager.getReflectionAxisFor(piece))
        .frame(width: manager.blockSize*manager.getWidth(outline: piece.outline),
               height: manager.blockSize*manager.getHeight(outline: piece.outline))
        .offset(x: manager.getXY(piece: piece).x*manager.blockSize, y: manager.getXY(piece: piece).y*manager.blockSize)
        .offset(offset)
        .animation(.easeIn, value: piece.position)
        .opacity(piece.position == manager.solutionPositionFor(piece) ? 0.7 : 1)
        .gesture(tapGesture)
        .gesture(longPressGesture)
        .gesture(dragGesture)
    }
}
