import { useEffect, useRef, useState, type FC } from "react"

type Props = {
  index: number
  color: "black" | "white" | "empty"
  onClick?: () => void
}

const SingleStone: FC<Props> = ({ index, color, onClick }) => {
  const ref = useRef<HTMLButtonElement>(null)
  const [fontSize, setFontSize] = useState<number>(0)
  useEffect(() => {
    if (ref.current) {
      setFontSize(ref.current.offsetHeight * 0.5)
    }
  })

  if (color === "white") {
    return (
      <button
        onClick={onClick}
        className="bg-white rounded-full text-black m-[2%]"
        style={{ fontSize: fontSize }}
        ref={ref}
      >
        {index}
      </button>
    )
  } else if (color === "black") {
    return (
      <button
        onClick={onClick}
        className="bg-black rounded-full text-white m-[2%]"
        style={{ fontSize: fontSize }}
        ref={ref}
      >
        {index}
      </button>
    )
  } else {
    return <button onClick={onClick} className="bg-transparent" />
  }
}

export default SingleStone
