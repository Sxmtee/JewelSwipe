// enum Hori { none, one, two, three }

// enum Verti { none, one, two, three, four }

enum PieceType {
  one("assets/images/icey.png"),
  two("assets/images/Game Over Block.png"),
  three("assets/images/jewel.png"),
  four("assets/images/icey.png"),
  none;

  const PieceType([this.path = ""]);
  final String path;
}

class CompoundPiece {
  final Piece subpiece;
  List<List<bool>> occupations;

  CompoundPiece(this.subpiece, this.occupations);

  static List<List<List<bool>>> pieces = [
    [
      [true],
    ],
    [
      [true, true],
    ],

    // twos
    [
      [false, true],
      [true, true],
    ],
    [
      [true, false],
      [true, true],
    ],
    [
      [true, true],
      [true, false],
    ],
    [
      [true, true],
      [false, true],
    ],
    [
      [true],
      [true],
    ],
    [
      [false, true, false],
      [true, true, true],
    ],
    [
      [true, true, true],
      [false, true, false],
    ],
    [
      [true, true, false],
      [false, true, true],
    ],
    [
      [false, true, true],
      [true, true, false],
    ],
    [
      [true, true, true],
      [true, false, false],
    ],
    [
      [false, false, true],
      [true, true, true],
    ],
    [
      [true, false, false],
      [true, true, true],
    ],
    [
      [true, true, true],
      [false, false, true],
    ],
    [
      [true, true],
      [true, true],
    ],

    //threes
    [
      [false, true],
      [true, true],
      [true, false],
    ],
    [
      [true, false],
      [true, true],
      [true, false],
    ],
    [
      [false, true],
      [true, true],
      [false, true],
    ],
    [
      [true, false],
      [true, true],
      [false, true],
    ],
    [
      [true, true],
      [false, true],
      [false, true],
    ],
    [
      [true, false],
      [true, false],
      [true, true],
    ],
    [
      [true, true],
      [true, false],
      [true, false],
    ],
    [
      [false, true],
      [false, true],
      [true, true],
    ],
  ];
}

class Piece {
  final PieceType pieceType;
  final int length;

  Piece([this.pieceType = PieceType.none, this.length = 0]);

  Piece copy() => Piece(pieceType, length);
}
