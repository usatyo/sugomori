import { useState } from "react"

const embedBaseUrl = "https://www.youtube.com/oembed"
const youtubeBaseUrl = "https://www.youtube.com/watch"

const useEmbedApi = () => {
  const [embedUrl, setEmbedUrl] = useState<URL>(new URL(embedBaseUrl))
  const [youtubeUrl, setYoutubeUrl] = useState<string>("")
  const [title, setTitle] = useState<string>("")
  const [authorName, setAuthorName] = useState<string>("")
  const [thumbnailUrl, setThumbnailUrl] = useState<string>("")

  const setParams = (videoId: string) => {
    setEmbedUrl(new URL(embedBaseUrl))
    const regexp = /^[a-zA-Z0-9_-]{11}$/
    if (!regexp.test(videoId)) {
      throw new Error("Invalid video ID")
    }
    const youtubeUrlObject = new URL(youtubeBaseUrl)
    youtubeUrlObject.searchParams.append("v", videoId)
    setYoutubeUrl(youtubeUrlObject.toString())
    embedUrl.searchParams.append("format", "json")
    embedUrl.searchParams.append("url", youtubeUrlObject.toString())
  }

  const fetchData = async () => {
    const response = await fetch(embedUrl.toString())
    if (!response.ok) {
      throw new Error("Network response was not ok")
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
