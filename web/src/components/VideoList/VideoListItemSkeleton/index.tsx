import { Skeleton } from "@/components/ui/skeleton"
import type { FC } from "react"

const VideoListItemSkeleton: FC = () => {
  return (
    <div className="@container">
      <div className="w-full flex gap-4 p-4 lg:p-6">
        <Skeleton className="w-1/2 @lg:w-50 aspect-4/3" />
        <div className="grow flex flex-col gap-2">
          <Skeleton className="w-full h-6" />
          <Skeleton className="w-1/3 h-6" />
          <Skeleton className="w-1/2 h-6" />
        </div>
      </div>
    </div>
  )
}

export default VideoListItemSkeleton
