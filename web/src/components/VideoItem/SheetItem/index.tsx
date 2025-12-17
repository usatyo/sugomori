import type { FC } from "react"

type Props = {
  videoId: string
}

const SheetItem: FC<Props> = ({ videoId }) => {
  return (
    <div>
      <iframe src={`https://www.youtube.com/embed/${videoId}`} className="w-1/2 aspect-video"></iframe>
    </div>
  )
}

export default SheetItem
