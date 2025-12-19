import type { FC } from "react"

type Props = {
  index: number
  color: "black" | "white" | "empty"
  onClick?: () => void
}

const SingleStone: FC<Props> = ({ index, color, onClick }) => {
  if (color === "white") {
    return (
      <button onClick={onClick} className="bg-white rounded-full text-black m-[2%]">
        {index}
      </button>
    )
  } else if (color === "black") {
    return (
      <button onClick={onClick} className="bg-black rounded-full text-white m-[2%]">
        {index}
      </button>
    )
  } else {
    return (
      <button onClick={onClick} className="bg-transparent" />
    )
  }
}

export default SingleStone
