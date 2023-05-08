enum Hori { none, one, two, three }

enum Verti { none, one, two, three, four }

class Piece {
  List<List<bool>> occupations;
  Hori hori;
  Verti verti;

  Piece(this.occupations, this.hori, this.verti);

  static List<Piece> pieces = [
    // ones
    Piece(
      [
        [true],
      ],
      Hori.one,
      Verti.one,
    ),
    Piece(
      [
        [true, true],
      ],
      Hori.one,
      Verti.two,
    ),
    Piece(
      [
        [true, true, true]
      ],
      Hori.one,
      Verti.three,
    ),
    Piece(
      [
        [true, true, true, true],
      ],
      Hori.one,
      Verti.four,
    ),

    // twos
    Piece(
      [
        [true, false],
        [false, true],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [false, true],
        [true, false],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [false, true],
        [true, true],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [true, false],
        [true, true],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [true, true],
        [true, false],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [true, true],
        [false, true],
      ],
      Hori.two,
      Verti.two,
    ),
    Piece(
      [
        [true],
        [true],
      ],
      Hori.two,
      Verti.one,
    ),
    Piece(
      [
        [false, true, false],
        [true, true, true],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, true, true],
        [false, true, false],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, true, false],
        [false, true, true],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [false, true, true],
        [true, true, false],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, true, true],
        [true, false, false],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [false, false, true],
        [true, true, true],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, false, false],
        [true, true, true],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, true, true],
        [false, false, true],
      ],
      Hori.two,
      Verti.three,
    ),
    Piece(
      [
        [true, true],
        [true, true],
      ],
      Hori.two,
      Verti.two,
    ),

    //threes
    Piece(
      [
        [true, false],
        [true, true],
        [true, false],
      ],
      Hori.three,
      Verti.two,
    ),
    Piece(
      [
        [false, true],
        [true, true],
        [false, true],
      ],
      Hori.three,
      Verti.two,
    ),
    Piece(
      [
        [true, true],
        [false, true],
        [false, true],
      ],
      Hori.three,
      Verti.two,
    ),
    Piece(
      [
        [true, false],
        [true, false],
        [true, true],
      ],
      Hori.three,
      Verti.two,
    ),
    Piece(
      [
        [true, true],
        [true, false],
        [true, false],
      ],
      Hori.three,
      Verti.two,
    ),
    Piece(
      [
        [false, true],
        [false, true],
        [true, true],
      ],
      Hori.three,
      Verti.two,
    ),
  ];
}
