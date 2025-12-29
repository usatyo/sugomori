import { useEffect, useRef, useState, type FC } from "react"
import SingleStone from "./SingleStone"
import useGoban from "./useGoban"

type Props = {}

const Goban: FC<Props> = () => {
  const { canvasRef, drawGoban, stoneMatrix, onClickStone } = useGoban()
  const [height, setHeight] = useState<number>(0)
  const ref = useRef<HTMLDivElement>(null)
  useEffect(() => {
    drawGoban()
    if (ref.current) {
      setHeight(ref.current.offsetHeight)
    }
  }, [])

  return (
    <div className="grow" ref={ref} style={{ width: height }}>
      <div className="relative w-full aspect-square">
        <canvas
          width={1000}
          height={1000}
          ref={canvasRef}
          className="absolute inset-0 w-full h-full bg-amber-400"
        ></canvas>
        <div className="absolute inset-0 w-full h-full grid grid-cols-19 grid-rows-19 p-[1%] z-10">
          {stoneMatrix.flat().map((stone, idx) => (
            <SingleStone
              key={idx}
              index={stone.index + 1}
              color={stone.color}
              onClick={() => onClickStone(stone.x, stone.y)}
            />
          ))}
        </div>
      </div>
    </div>
  )
}

export default Goban
