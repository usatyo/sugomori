import { useEffect } from "react"
import useEmbedApi from "../../hooks/useEmbedApi"

type Props = {
  videoId: string
}

const VideoCard: React.FC<Props> = ({ videoId }) => {
  const { setParams, fetchData, youtubeUrl, title, authorName, thumbnailUrl } =
    useEmbedApi()

  useEffect(() => {
    setParams(videoId)
    const asyncData = async () => {
      await fetchData()
    }
    asyncData()
  }, [videoId])

  return (
    <a
      href={youtubeUrl}
      target="_blank"
      rel="noopener noreferrer"
      className="flex"
    >
      {thumbnailUrl !== "" && <img src={thumbnailUrl} alt={title} />}
      <div>
        <h3>{title}</h3>
        <p>{authorName}</p>
      </div>
    </a>
  )
}

export default VideoCard
