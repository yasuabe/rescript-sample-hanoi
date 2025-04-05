type disc = int
type rod = list<disc>
type state = (rod, rod, rod)

let draw: (state, Dom.element) => unit
let solve: (int, int, int, int) => list<(int, int)>
let applyMove: (state, (int, int)) => state
let initState: state