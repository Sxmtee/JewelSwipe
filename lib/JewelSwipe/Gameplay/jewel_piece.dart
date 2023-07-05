// enum Hori { none, one, two, three }

// enum Verti { none, one, two, three, four }

enum PieceType {
  one("assets/images/Blue1.png"),
  two("assets/images/Blue2.png"),
  three("assets/images/Blue3.png"),
  four("assets/images/Blue4.png"),
  five("assets/images/Orange.png"),
  six("assets/images/Orange2.png"),
  seven("assets/images/Orange3.png"),
  eight("assets/images/Orange4.png"),
  nine("assets/images/Pink1.png"),
  ten("assets/images/Pink2.png"),
  eleven("assets/images/Pink3.png"),
  twelve("assets/images/Pink4.png"),
  thirteen("assets/images/Purple1.png"),
  fourteen("assets/images/Purple2.png"),
  fifteen("assets/images/Purple3.png"),
  sixteen("assets/images/Purple4.png"),
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
