import { useContext, useRef, useState } from "react"
import {
  generateEmptyMatrix,
  reversedColor,
  type Stone,
  type StoneColor,
} from "../../models/joseki"
import { JosekiContext } from "../../provider/JosekiProvider"
import { getProcessedBoard } from "../../utils/goGameRule"

export const useGoban = () => {
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
    ctx.lineWidth = 3

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
          20,
          0,
          2 * Math.PI
        )
        ctx.fill()
      })
    })
  }

  const isOverMaxStones = (): boolean => {
    return joseki.stoneList.length >= 99
  }

  const { joseki, setJoseki } = useContext(JosekiContext)
  const [stoneMatrix, setStoneMatrix] = useState<Array<Array<Stone>>>(
    generateEmptyMatrix()
  )
  const [nextColor, setNextColor] = useState<StoneColor>("black")
  const [isEditable, setIsEditable] = useState<boolean>(true)

  const onClickStone = (x: number, y: number) => {
    if (!isEditable) return
    if (isOverMaxStones()) return

    if (!joseki.pushStone(nextColor, x, y)) {
      return
    }
    setStoneMatrix(getProcessedBoard(joseki.stoneList))
    setNextColor(reversedColor(nextColor))
  }

  return {
    canvasRef,
    drawGoban,
    stoneMatrix,
    onClickStone,
    setJoseki,
    setIsEditable,
  }
}
