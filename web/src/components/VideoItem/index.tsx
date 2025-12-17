import { useEffect } from "react"
import useEmbedApi from "../../hooks/useEmbedApi"
import { Sheet, SheetContent, SheetTrigger } from "../ui/sheet"
import DetailDrawerItem from "./SheetItem"

type Props = {
  videoId: string
}

const VideoItem: React.FC<Props> = ({ videoId }) => {
  const { setParams, fetchData, title, authorName, thumbnailUrl } =
    useEmbedApi()

  useEffect(() => {
    setParams(videoId)
    const asyncData = async () => {
      await fetchData()
    }
    asyncData()
  }, [videoId])

  return (
    <Sheet>
      <SheetTrigger className="w-full flex cursor-pointer hover:bg-gray-50">
        <div className="flex p-4">
          <img
            src={thumbnailUrl}
            alt={title}
            className="w-50 aspect-video object-contain"
          />
          <div>
            <h3>{title}</h3>
            <p>{authorName}</p>
          </div>
        </div>
      </SheetTrigger>
      <SheetContent className="max-w-none! w-[1000px]">
        <DetailDrawerItem videoId={videoId} />
      </SheetContent>
    </Sheet>
  )
}

export default VideoItem
