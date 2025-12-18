import { useEffect, type FC } from "react"
import SingleStone from "./SingleStone"
import useGoban from "./useGoban"

type Props = {}

const Goban: FC<Props> = () => {
  const { canvasRef, drawGoban, stoneMatrix, onClickStone } = useGoban()
  useEffect(() => {
    drawGoban()
  }, [])

  return (
    <div className="relative w-full self-stretch aspect-square">
      <canvas
        width={3600}
        height={3600}
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
  )
}

export default Goban
