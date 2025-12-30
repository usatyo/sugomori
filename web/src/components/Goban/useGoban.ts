import { useContext, useEffect, useRef, useState } from "react"
import {
  generateEmptyMatrix,
  reversedColor,
  type Stone,
} from "../../models/joseki"
import { JosekiContext } from "../../provider/JosekiProvider"
import { getProcessedBoard } from "../../utils/goGameRule"
import { toast } from "sonner"

const useGoban = () => {
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const drawGoban = () => {
    const canvas = canvasRef.current
    if (!canvas) return
    const ctx = canvas.getContext("2d")
    if (!ctx) return

    const size = canvas.width
    const padding = size / 100
    const cellSize = (size - padding * 2) / 19
    ctx.strokeStyle = "#000000"
    ctx.fillStyle = "#000000"
    ctx.lineWidth = 0.7

    // Draw grid lines
    for (let i = 0; i < 19; i++) {
      ctx.beginPath()
      ctx.moveTo(padding + cellSize / 2, padding + cellSize / 2 + i * cellSize)
      ctx.lineTo(
        size - padding - cellSize / 2,
        padding + cellSize / 2 + i * cellSize
      )
      ctx.stroke()

      ctx.beginPath()
      ctx.moveTo(padding + cellSize / 2 + i * cellSize, padding + cellSize / 2)
      ctx.lineTo(
        padding + cellSize / 2 + i * cellSize,
        size - padding - cellSize / 2
      )
      ctx.stroke()
    }

    // Draw star points
    const starPoints = [3, 9, 15]
    starPoints.forEach((x) => {
      starPoints.forEach((y) => {
        ctx.beginPath()
        ctx.arc(
          padding + cellSize / 2 + x * cellSize,
          padding + cellSize / 2 + y * cellSize,
          5,
          0,
          2 * Math.PI
        )
        ctx.fill()
      })
    })
  }

  const isOverMaxStones = (): boolean => {
    return joseki.stoneList.length >= 30
  }

  const { joseki, setJoseki, nextColor, setNextColor, isEditable, isZooming } =
    useContext(JosekiContext)
  const [stoneMatrix, setStoneMatrix] = useState<Array<Array<Stone>>>(
    generateEmptyMatrix()
  )

  const onClickStone = (x: number, y: number) => {
    if (!isEditable) return
    if (isOverMaxStones()) {
      toast.error("最大で30手まで石を配置できます")
      return
    }

    if (!joseki.pushStone(nextColor, x, y)) {
      return
    }
    setStoneMatrix(getProcessedBoard(joseki.stoneList))
    setNextColor(reversedColor(nextColor))
  }

  // context が変更された際に再レンダリングを行う
  useEffect(() => {
    setStoneMatrix(getProcessedBoard(joseki.stoneList))
  }, [joseki])

  return {
    canvasRef,
    drawGoban,
    stoneMatrix,
    onClickStone,
    setJoseki,
    isZooming,
  }
}

export default useGoban
