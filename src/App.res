open Hanoi

@react.component
let make = () => {
  // let (tick, setTick) = React.useState(() => 0)
  let (currentState, setCurrentState) = React.useState(() => initState)
  let movesRef = React.useRef(() => solve(3, "A", "C", "B"))
  let indexRef = React.useRef(0)

  React.useEffect1(() => {
    let id = ref(Js.Global.setInterval(() => (), 1000)) // placeholder 

    id.contents = Js.Global.setInterval(() => {
      let i = indexRef.current
      let moves = movesRef.current()
      switch Belt.List.get(moves, i) {
      | Some(move) => {
          setCurrentState(state => applyMove(state, move))
          indexRef.current = i + 1
        }
      | None => Js.Global.clearInterval(id.contents)
      }
    }, 1000)

    Some(() => Js.Global.clearInterval(id.contents))
  }, [])
  React.useEffect1(() => {
    switch (Webapi.Dom.document->Webapi.Dom.Document.getElementById("canvas_id")) {
    | Some(canvas) =>
        Js.Console.log(currentState)
        draw(currentState, canvas)
    | None => ()
    }
    None
  }, [currentState])

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->React.string} </h1>
    <canvas id="canvas_id" width="400" height="300" />
  </div>
}
