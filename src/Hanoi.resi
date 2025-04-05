type disc = int
type rod = list<disc>
type state = (rod, rod, rod)

let draw: (state, Dom.element) => unit
let solve: (int, string, string, string) => list<(string, string)>
let applyMove: (state, (string, string)) => state
let initState: state