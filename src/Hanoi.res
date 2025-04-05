open Webapi.Dom
open Webapi.Canvas
open Webapi.Canvas.Canvas2d

// Model --------------
type disc  = int
type rod   = list<disc>
type state = (rod, rod, rod)

let initState: state = (list{1, 2, 3}, list{}, list{})

let fromRods = ((a, b, c): state) => list{a, b, c}
let toRods   = (rods: list<rod>) => switch rods {
  | list{a, b, c} => (a, b, c)
  | _             => assert(false)
}

let getRod = ((a, b, c), (id: string)) =>
  switch id {
  | "A" => a
  | "B" => b
  | "C" => c
  | _   => assert(false)
  }

let setRod = ((a, b, c), id: string, newRod: rod) =>
  switch id {
  | "A" => (newRod, b, c)
  | "B" => (a, newRod, c)
  | "C" => (a, b, newRod)
  | _   => assert(false)
  }

// Solve / Move --------------
let rec solve = (n: int, from: string, to_: string, aux: string): list<(string, string)> =>
  if n > 0 {
    [
      solve(n - 1, from, aux, to_),
      list{(from, to_)},
      solve(n - 1, aux, to_, from)
    ] -> List.concatMany
  } else { list{} }

let applyMove = (state: state, (fromId, toId): (string, string)): state => {
  let fromRod = state -> getRod(fromId)
  let toRod   = state -> getRod(toId)

  state
    -> setRod(fromId, fromRod->List.tailExn)
    -> setRod(toId  , list{ fromRod->List.headExn, ...toRod })
}

// Draw ---------------
let drawDisc = (ctx: Canvas2d.t, x: float, y: float, size: int) => {
  let width  = 20.0 +. (float_of_int(size) *. 20.0)
  let height = 20.0

  let x'           = x -. (width /. 2.0)
  let (sty, value) = reifyStyle("teal")

  ctx -> setFillStyle(sty, value)
  ctx -> fillRect(~x = x', ~y = y, ~w = width, ~h = height)
}

let drawRod = (ctx: Canvas2d.t, height: float) => (x: float) => {
    let (sty, value) = reifyStyle("#990")
    ctx -> setFillStyle(sty, value)
    ctx -> fillRect(~x = x, ~y = 50.0, ~w = 10.0, ~h = height -. 70.0)
  }

let drawRods = (ctx: Canvas2d.t, height: float, xs: list<float>) =>
  xs -> List.forEach(drawRod(ctx, height))

let drawDiscs = (ctx: Canvas2d.t, height: float, rodX: list<float>, state: state) => {
  let baseY      = height -. 40.0
  let discHeight = 20.0

  state
  -> fromRods
  -> List.zip(rodX)
  -> List.forEach(((rod, x)) => 
    rod
    -> List.reverse
    -> List.forEachWithIndex((size, i) => {
      let y = baseY -. (float_of_int(i) *. discHeight)
      drawDisc(ctx, x, y, size)
    })
  )
}

let draw = (state: state, canvas: Dom.element) => {
  let ctx = canvas->CanvasElement.getContext2d

  let rect   = canvas->Element.getBoundingClientRect
  let width  = rect->DomRect.width
  let height = rect->DomRect.height

  ctx -> clearRect(~x = 0.0, ~y = 0.0, ~w = width, ~h = height)

  let rodX = list{1, 2, 3} -> List.map(n => Float.fromInt(n) *. width /. 4.0)

  ctx -> drawRods(height, rodX)
  ctx -> drawDiscs(height, rodX, state)
}