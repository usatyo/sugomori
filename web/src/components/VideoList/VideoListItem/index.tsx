import { useEffect } from "react"
import useEmbedApi from "../../../hooks/useEmbedApi"
import { Sheet, SheetContent, SheetTrigger } from "../../ui/sheet"
import SheetItem from "./SheetItem"

type Props = {
  videoId: string
}

const VideoListItem: React.FC<Props> = ({ videoId }) => {
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
      <SheetTrigger className="w-full cursor-pointer hover:bg-gray-50">
        <div className="flex gap-4 py-6 px-6">
          <img src={thumbnailUrl} alt={title} className="w-50 aspect-4/3" />
          <div className="flex flex-col gap-2">
            <h3 className="text-left text-md font-bold line-clamp-2 text-ellipsis">
              {title}
            </h3>
            <p className="text-left text-gray-400 line-clamp-1 text-ellipsis">
              {authorName}
            </p>
          </div>
        </div>
      </SheetTrigger>
      <SheetContent className="max-w-none! w-1/2 rounded-l-md">
        <SheetItem
          videoId={videoId}
          title={title}
          authorName={authorName}
        />
      </SheetContent>
    </Sheet>
  )
}

export default VideoListItem
