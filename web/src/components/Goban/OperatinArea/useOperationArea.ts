import { Joseki, reversedColor } from "@/models/joseki"
import { JosekiContext } from "@/provider/JosekiProvider"
import { useContext } from "react"

const useOperationArea = () => {
  const { setJoseki, setNextColor, isEditable, isZooming, setIsZooming } =
    useContext(JosekiContext)

  const clear = () => {
    setJoseki(new Joseki([]))
    setNextColor("black")
  }

  const backFive = () => {
    setJoseki((prev) => {
      const newJoseki = new Joseki([...prev.stoneList])
      const color = newJoseki.popStones(5)
      setNextColor(color)
      return newJoseki
    })
  }

  const back = () => {
    setJoseki((prev) => {
      const newJoseki = new Joseki([...prev.stoneList])
      const color = newJoseki.popStone()
      setNextColor(color)
      return newJoseki
    })
  }

  const pass = () => {
    // バックエンドの仕様と共通のため、手番を変えるだけで良い
    setNextColor((prev) => reversedColor(prev))
  }

  return { clear, backFive, back, pass, isZooming, setIsZooming, isEditable }
}

export default useOperationArea
