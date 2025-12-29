import { LoadingContext } from "@/provider/LoadingProvider"
import { MediaContext } from "@/provider/MediaProvider"
import { useContext, useEffect } from "react"
import useEmbedApi from "../../../hooks/useEmbedApi"
import { Sheet, SheetContent, SheetTrigger } from "../../ui/sheet"
import SheetItem from "./SheetItem"

type Props = {
  videoId: string
}

const VideoListItem: React.FC<Props> = ({ videoId }) => {
  const { setParams, fetchData, title, authorName, thumbnailUrl } =
    useEmbedApi()
  const { setLoading } = useContext(LoadingContext)
  const { isMobile } = useContext(MediaContext)

  useEffect(() => {
    setLoading(true)
    if (setParams(videoId)) {
      const asyncData = async () => {
        await fetchData()
      }
      asyncData()
    }
    setLoading(false)
  }, [videoId])

  if (title === "" && authorName === "" && thumbnailUrl === "") {
    return null
  }

  return (
    <Sheet>
      <SheetTrigger className="w-full cursor-pointer hover:bg-gray-50 @container">
        <div className="flex gap-4 p-4 lg:p-6">
          <img
            src={thumbnailUrl}
            alt={title}
            className="w-1/2 @lg:w-50 aspect-4/3"
          />
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
      <SheetContent
        side={isMobile ? "bottom" : "right"}
        className="max-w-none! h-2/3 w-screen lg:h-screen lg:w-[700px] rounded-l-md"
      >
        <SheetItem videoId={videoId} title={title} authorName={authorName} />
      </SheetContent>
    </Sheet>
  )
}

export default VideoListItem
