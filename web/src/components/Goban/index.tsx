import { CardSizeContext } from "@/provider/CardSizeProvider"
import { useContext, useEffect, useRef, type FC } from "react"
import SingleStone from "./SingleStone"
import useGoban from "./useGoban"

type Props = {}

const Goban: FC<Props> = () => {
  const { canvasRef, drawGoban, stoneMatrix, onClickStone, isZooming } =
    useGoban()
  const { size, setSize } = useContext(CardSizeContext)
  const ref = useRef<HTMLDivElement>(null)
  useEffect(() => {
    if (ref.current) {
      setSize(Math.max(ref.current.offsetHeight, ref.current.offsetWidth))
    }
    drawGoban()
  }, [])

  return (
    <div
      className="self-stretch grow overflow-clip"
      ref={ref}
      style={{ height: size, width: size }}
    >
      <div
        className="relative w-full aspect-square origin-top-left"
        style={{ scale: isZooming ? 1.55 : 1 }}
      >
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
