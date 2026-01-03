import { checkVideoId } from "@/utils/videoId"
import { useState } from "react"
import { toast } from "sonner"

const embedBaseUrl = "https://www.youtube.com/oembed"
const youtubeBaseUrl = "https://www.youtube.com/watch"

const useEmbedApi = () => {
  const [embedUrl, setEmbedUrl] = useState<URL>(new URL(embedBaseUrl))
  const [youtubeUrl, setYoutubeUrl] = useState<string>("")
  const [title, setTitle] = useState<string>("")
  const [authorName, setAuthorName] = useState<string>("")
  const [thumbnailUrl, setThumbnailUrl] = useState<string>("")

  const setParams = (videoId: string): boolean => {
    setEmbedUrl(new URL(embedBaseUrl))
    if (!checkVideoId(videoId)) {
      toast.error("無効な動画リンクです")
      return false
    }
    const youtubeUrlObject = new URL(youtubeBaseUrl)
    youtubeUrlObject.searchParams.append("v", videoId)
    setYoutubeUrl(youtubeUrlObject.toString())
    embedUrl.searchParams.append("format", "json")
    embedUrl.searchParams.append("url", youtubeUrlObject.toString())
    return true
  }

  const fetchData = async () => {
    const response = await fetch(embedUrl.toString())
    if (!response.ok) {
      toast.error("動画情報の取得に失敗しました")
      return
    }
    const json = await response.json()
    setTitle(json.title)
    setAuthorName(json.author_name)
    setThumbnailUrl(json.thumbnail_url)
  }

  return {
    setParams,
    fetchData,
    youtubeUrl,
    title,
    authorName,
    thumbnailUrl,
  }
}

export default useEmbedApi
