open Hanoi

let useCanvasDraw = (~state: state) => {
  React.useEffect1(() => {
    switch (Webapi.Dom.document->Webapi.Dom.Document.getElementById("canvas_id")) {
    | Some(canvas) =>
        Js.Console.log(state)
        draw(state, canvas)
    | None => ()
    }
    None
  }, [state])
  }

let useAutoPlay = (~setState: (state => state) => unit, ~moves: unit => list<(int, int)>) => {
  let indexRef = React.useRef(0)

  React.useEffect1(() => {
    let id = ref(Js.Global.setInterval(() => (), Config.interval * 3))

    id.contents = Js.Global.setInterval(() => {
      let i     = indexRef.current
      let moves = moves()
      switch List.get(moves, i) {
      | Some(move) => {
          setState(state => applyMove(state, move))
          indexRef.current = i + 1
        }
      | None => Js.Global.clearInterval(id.contents)
      }
    }, Config.interval)
    Some(() => Js.Global.clearInterval(id.contents))
  }, [])
}

let useHanoiPlayer = () => {
  let (state, setState) = React.useState(() => initState)
  let movesRef = React.useRef(() => solve(Config.disc_num, 0, 2, 1))

  useAutoPlay(~setState = setState, ~moves = movesRef.current)
  (state)
}

@react.component
let make = () => {
  let currentState = useHanoiPlayer()
  useCanvasDraw(~state = currentState)

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"Tower of Hanoi"->React.string} </h1>
    <canvas id="canvas_id" width="400" height="300" />
  </div>
}
